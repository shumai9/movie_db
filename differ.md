diff --git a/app/controllers/movies.rb b/app/controllers/movies.rb
index 3d252c4..d5577cc 100644
--- a/app/controllers/movies.rb
+++ b/app/controllers/movies.rb
@@ -7,8 +7,11 @@ MovieDb::App.controllers :movies do
   
   get :index, :with => :id do
     @movie = Movie.find(params[:id])
-    @movie.title
+    @title = @movie.title
+    @genres = @movie.genres
+    render 'movie'
   end
+
   
   # get :index, :map => '/foo/bar' do
   #   session[:foo] = 'bar'
diff --git a/app/views/movies/index.erb b/app/views/movies/index.erb
index 7aa4d4a..3f61dbc 100644
--- a/app/views/movies/index.erb
+++ b/app/views/movies/index.erb
@@ -9,8 +9,8 @@
 <h1>Top 5 Movies</h1>
 <ul>
   <% @movies.each do |movie| %>
-    <li><%= movie.title %> - <%= movie.year %></li>
+    <li><a href="/movies/<%= movie.id %>"> <%= movie.title %> - <%= movie.year %> </a></li>
   <% end %>
 </ul>
 </body>
-</html>
\ No newline at end of file
+</html>
diff --git a/db/schema.rb b/db/schema.rb
index 1ed55f2..c2284fa 100644
--- a/db/schema.rb
+++ b/db/schema.rb
@@ -10,7 +10,16 @@
 #
 # It's strongly recommended that you check this file into your version control system.
 
-ActiveRecord::Schema.define(version: 1) do
+ActiveRecord::Schema.define(version: 2) do
+
+  create_table "genres", force: :cascade do |t|
+    t.string "name", null: false
+  end
+
+  create_table "genres_movies", id: false, force: :cascade do |t|
+    t.integer "genre_id", null: false
+    t.integer "movie_id", null: false
+  end
 
   create_table "movies", force: :cascade do |t|
     t.string "title", null: false
diff --git a/db/seeds.rb b/db/seeds.rb
index e4dd0f7..5ec6e07 100644
--- a/db/seeds.rb
+++ b/db/seeds.rb
@@ -1,7 +1,35 @@
 require 'csv'
 
-csv_contents = CSV.read("./db/IMDB-Movie-Data.csv")
-csv_contents.shift
+ csv_contents = CSV.read("./db/IMDB-Movie-Data.csv")
+ csv_contents.shift
+
+output = []
+csv_contents.each do |row| 
+  row[2].split(',').to_a.each do |g|
+   output << g
+ end
+end
+
+genres = output.uniq
+genres.each do |genre| 
+  Genre.create!(name: genre)
+end
+
+##########################################
+
 csv_contents.each do |row|
-  Movie.create!(title: row[1], description: row[3], year: row[6], runtime: row[7], rating: row[8], votes: row[9], revenue: row[10].to_f*1000000, metascore: row[11])
-end
\ No newline at end of file
+
+  genres = []
+
+  row[2].split(',').to_a.each do |g|
+   genres << Genre.find_by(name: g)
+ end
+
+ movie = Movie.create!(title: row[1], description: row[3], year: row[6], runtime: row[7], rating: row[8], votes: row[9], revenue: row[10].to_f*1000000, metascore: row[11])
+
+ genres.each do |genre|
+  movie.genres << genre
+ end
+
+end
+
diff --git a/models/movie.rb b/models/movie.rb
index 13d73ce..6afb83f 100644
--- a/models/movie.rb
+++ b/models/movie.rb
@@ -1,3 +1,4 @@
 class Movie < ActiveRecord::Base
+  has_and_belongs_to_many :genres
 
 end

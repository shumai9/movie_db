require 'csv'

 csv_contents = CSV.read("./db/IMDB-Movie-Data.csv")
 csv_contents.shift

output = []
csv_contents.each do |row| 
  row[2].split(',').to_a.each do |g|
   output << g
 end
end

genres = output.uniq
genres.each do |genre| 
  Genre.create!(name: genre)
end

##########################################

csv_contents.each do |row|

  genres = []

  row[2].split(',').to_a.each do |g|
   genres << Genre.find_by(name: g)
 end

 movie = Movie.create!(title: row[1], description: row[3], year: row[6], runtime: row[7], rating: row[8], votes: row[9], revenue: row[10].to_f*1000000, metascore: row[11])

 genres.each do |genre|
  movie.genres << genre
 end

end


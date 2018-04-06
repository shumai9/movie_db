require 'csv'

 csv_contents = CSV.read("./db/IMDB-Movie-Data.csv")
 csv_contents.shift

output = []
csv_contents.each do |row| 
  movie = Movie.create!(title: row[1], description: row[3], year: row[6], runtime: row[7], rating: row[8], votes: row[9], revenue: row[10].to_f*1000000, metascore: row[11])
  row[2].split(',').each do |g|
    movie.genres << Genre.find_or_create_by(name: g)
  end
end


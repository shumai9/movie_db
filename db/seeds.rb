require 'csv'

csv_contents = CSV.read("./db/IMDB-Movie-Data.csv")
csv_contents.shift
csv_contents.each do |row|
  Movie.create!(title: row[1], description: row[3], year: row[6], runtime: row[7], rating: row[8], votes: row[9], revenue: row[10].to_f*1000000, metascore: row[11])
end
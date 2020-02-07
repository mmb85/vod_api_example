(1..10).each { User.create(email: Faker::Internet.unique.email) }
(1..20).each { Movie.create(title: Faker::Book.unique.title, plot: Faker::Movie.quote)}

(1..5).each { Season.create(title: Faker::Book.unique.title, plot: Faker::Movie.quote, number: 1)}

Season.find_each do |season|
  se = season.dup
  se.number = season.number + 1
  se.save!
end

Season.find_each do |season|
  (1..8).each { |num| Episode.create(title: Faker::Book.unique.title, season_id: season.id, number: num) }
end

Purchase.create(movie_id: Movie.second.id, user_id: User.second.id, price: 12.99, quality: 'HD')
Purchase.create(movie_id: Movie.third.id, user_id: User.first.id, price: 12.99, quality: 0)
Purchase.create(movie_id: Movie.second.id, user_id: User.first.id, price: 12.99, quality: 'SD')
# User buy the movie with 2 different qualities, permited
Purchase.create(movie_id: Movie.second.id, user_id: User.first.id, price: 12.99, quality: 1)
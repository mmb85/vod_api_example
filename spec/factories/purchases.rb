# == Schema Information
#
# Table name: purchases
#
#  id         :integer          not null, primary key
#  movie_id   :integer
#  season_id  :integer
#  user_id    :integer          not null
#  price      :float            not null
#  quality    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  expired    :boolean          default(FALSE)
#

FactoryBot.define do
  factory :purchase do
    factory :purchase_movie, aliases: [:sd_purchase] do
      movie
      user
      price { 2.99 }
      quality { 'SD' }
    end

    factory :purchase_season, aliases: [:hd_purchase] do
      season
      user
      price { 24.99 }
      quality { 'HD' }
    end
  end	
end
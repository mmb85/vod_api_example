# == Schema Information
#
# Table name: movies
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  plot       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :movie do
    title { "The Godfather" }
    plot { "The aging patriarch of an organized crime dynasty transfers control of his clandestine empire to his reluctant son." }
  end
end

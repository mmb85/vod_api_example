# == Schema Information
#
# Table name: seasons
#
#  id         :integer          not null, primary key
#  title      :string
#  plot       :string
#  number     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :season do
    title { "MyString" }
    plot { "MyString" }
    number { 1 }
  end
end

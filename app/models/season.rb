# == Schema Information
#
# Table name: seasons
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  plot       :string
#  number     :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Season < ApplicationRecord
  has_many :purchases
  has_many :users, through: :purchases
  has_many :episodes, ->{ order(number: :asc) }, dependent: :destroy
end

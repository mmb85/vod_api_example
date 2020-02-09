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

class SeasonSerializer < ActiveModel::Serializer
  attributes :id, :title, :plot, :number, :created_at

  has_many :episodes
end

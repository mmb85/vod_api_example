class SeasonSerializer < ActiveModel::Serializer
  attributes :id, :title, :plot, :number, :created_at

  has_many :episodes
end
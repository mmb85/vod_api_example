# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  email      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ApplicationRecord

  has_many :purchases, dependent: :destroy
  has_many :movies, through: :purchases

  validates_uniqueness_of :email
  validates_presence_of :email

  after_commit :create_json_cache

  def self.cache_key(user)
    {
      serializer: 'users',
      stat_record: User.maximum(:updated_at)
    }
  end  

  private
  def create_json_cache
    CreateUsersJsonCacheJob.perform_later
  end


end

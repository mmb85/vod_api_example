# == Schema Information
#
# Table name: episodes
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  plot       :string
#  season_id  :integer          not null
#  number     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Episode, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

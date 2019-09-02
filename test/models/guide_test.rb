# == Schema Information
#
# Table name: guides
#
#  id          :bigint(8)        not null, primary key
#  name        :string
#  order       :integer          default(0)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  slug        :string
#  category_id :bigint(8)
#  image       :string
#

require 'test_helper'

class GuideTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

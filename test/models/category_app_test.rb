# == Schema Information
#
# Table name: category_apps
#
#  id          :bigint(8)        not null, primary key
#  name        :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  icon        :string
#

require 'test_helper'

class CategoryAppTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

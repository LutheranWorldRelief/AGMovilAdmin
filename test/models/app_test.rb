# == Schema Information
#
# Table name: apps
#
#  id              :bigint(8)        not null, primary key
#  name            :string
#  image           :string
#  app_type        :integer
#  app_url         :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  category_app_id :bigint(8)
#

require 'test_helper'

class AppTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

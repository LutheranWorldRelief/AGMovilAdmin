# == Schema Information
#
# Table name: articles
#
#  id          :bigint(8)        not null, primary key
#  name        :string
#  title       :string
#  description :text
#  content     :text
#  order       :integer          default(0)
#  section_id  :bigint(8)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  slug        :string
#

require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

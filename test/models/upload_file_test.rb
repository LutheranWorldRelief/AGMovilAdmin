# == Schema Information
#
# Table name: upload_files
#
#  id          :bigint(8)        not null, primary key
#  file_upload :string
#  order       :integer          default(0)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  description :text
#  name        :string
#  file_type   :integer
#  guide_id    :bigint(8)
#

require 'test_helper'

class UploadFileTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

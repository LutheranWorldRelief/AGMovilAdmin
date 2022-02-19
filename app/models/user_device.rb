# == Schema Information
#
# Table name: user_devices
#
#  id         :bigint           not null, primary key
#  token      :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class UserDevice < ApplicationRecord
end

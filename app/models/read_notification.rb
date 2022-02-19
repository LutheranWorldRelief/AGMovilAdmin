# == Schema Information
#
# Table name: read_notifications
#
#  id              :bigint           not null, primary key
#  user_key        :text
#  notification_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class ReadNotification < ApplicationRecord
end

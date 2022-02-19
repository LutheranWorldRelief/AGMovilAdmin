# == Schema Information
#
# Table name: delete_notifications
#
#  id              :bigint           not null, primary key
#  user_key        :text
#  notification_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class DeleteNotification < ApplicationRecord
end

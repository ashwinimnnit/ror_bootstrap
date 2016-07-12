class Notification < ActiveRecord::Base
  belongs_to :notification_received, class_name: "User", foreign_key: "user_id"
  belongs_to :notification_sends, class_name: "User", foreign_key: "sender_id"
  def self.call_hook_before_publish(user, message, channel, sender)
    create(
      user_id: user.id,
      message: message,
      channel: channel,
      sender_id: sender
    )
  end

  def self.user_notification(user)
    where("user_id = ? AND seen = false", user.id).limit(5)
  end
end

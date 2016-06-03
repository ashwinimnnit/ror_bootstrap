class Message < ActiveRecord::Base

  def self.call_hook_before_publish(user, notification, channel)
  end
end

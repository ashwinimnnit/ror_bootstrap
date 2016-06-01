class Notification < ActiveRecord::Base
  belongs_to :user
  def self.call_hook_before_publish(user, block, channel)
    create(
      user: user,
      message: block,
      channel: channel
    )
  end
end

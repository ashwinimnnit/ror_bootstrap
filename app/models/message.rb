class Message < ActiveRecord::Base
  belongs_to :msg_received, class_name: "User", foreign_key: "receiver_id"
  belongs_to :msg_sends, class_name: "User", foreign_key: "sender_id"
  def self.call_hook_before_publish(*chat_params)
    sender = User.find_by_id(chat_params[3].to_i)
    create(user_message: chat_params[1],
           channel: chat_params[2],
           msg_received: chat_params[0],
           msg_sends:  sender
          )
  end
end

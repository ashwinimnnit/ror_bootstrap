# Talentica - bootstrap project
# Copyright   Ashwini Kumar
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
module ApplicationHelper
  def broadcast(channel, &block)
    message = { channel: channel, data: capture(&block) }
    uri = URI.parse("http://localhost:9292/faye")
    Net::HTTP.post_form(uri, message: message.to_json)
  end

  def users
    User.all.to_a
  end

  def show_unread_notification(user)
    Notification.where("seen = false AND user_id = #{user}").count
  end

  def user_chat_history(user1, user2)
    messages = Message.where("(receiver_id = ?  and sender_id = ?) or
                              (receiver_id = ?  and sender_id = ?)",
                             user1.id, user2.id, user2.id, user1.id
                            )
                      .order(created_at: "asc")
    align_user_chat(messages, user2)
  end

  def align_user_chat(messages, sender)
    s = ""
    messages.each do |msg|
      css_class = msg.sender_id == sender.id ? "show-chat" : "show-chat_"
      s += "<div class = 'gc'>\
           <span class = '#{css_class}'>\
             #{msg.user_message}</span></div><br>"
    end
    s.html_safe
  end
end

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
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  include ApplicationHelper
  def check_if_admin
    render_401 unless current_user.admin
  end

  def render_401
    render json: {
      status: 401,
      message: "You are not an authorised person to access this page"
    }
  end

  def push_notification(param)
    channel = param[:url]
    notification = param[:data]
    sender = param[:sender]
    # used so that valid entry is saved in notifications
    channel_prefix, user = validate_user_from_channel channel
    if user
      channel_prefix.camelize
                    .constantize
                    .call_hook_before_publish(user, notification, channel, sender)
      notification = show_unread_notification user.id if channel_prefix == "notification"
      push_on_channel(channel, notification)
    else
      logger.info("User doesn't exist for channel: #{channel}")
    end
  end

  def validate_user_from_channel(channel)
    arr = channel.split("/")
    [arr[1], User.find_by_id(arr[2].to_i)]
  end

  def push_on_channel(channel, notification)
    message = { channel: channel, data: notification }
    uri = URI.parse("http://localhost:9292/faye")
    res = Net::HTTP.post_form(uri, message: message.to_json)
    res.response.body
  end

  private

  def remove_unnecessary_whitespace(info)
    user_new_hash = {}
    user_info = info.to_h
    user_info.each do |uid, user_data|
      @tmp_hash = {}
      user_data.each do |key, value|
        @tmp_hash[key] = value.gsub(/\s+/, "")
      end
      user_new_hash[uid] = @tmp_hash
    end
    user_new_hash
  end
end

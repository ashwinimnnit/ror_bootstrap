# User Notification
class NotificationsController < ApplicationController
  def display_notification
    @unread_notification = []
    notification = Notification.user_notification current_user
    notification.each do |n|
      response = {}
      response[:message] = n.message
      response[:sender] = n.notification_sends
                           .firstname + "  " + n.notification_sends.lastname
      @unread_notification << response
    end
    Notification.where("user_id = #{current_user.id}").update_all(seen: true)
  end

  def send_notifications
    response = push_notification(params)
    render json: {
      message: response
    }
  end

  def logged_in_user
    render json: {
      user: current_user.id
    }
  end

  def chat
    @channel = params[:url]
    arr = validate_user_from_channel params[:url]
    @user = arr[1]
  end

  def testing
    user = params[:name]
    User.where("name = #{ashwiin}")
    user.each do |d|
      d.name = "sada"
      d.gat << user
    end
  end
end

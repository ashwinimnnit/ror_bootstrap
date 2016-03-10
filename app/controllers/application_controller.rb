class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
   protect_from_forgery with: :exception
   before_action :authenticate_user!
  def check_if_admin
    render_403 if !current_user.admin
  end


  def render_403
   render :json => { :Status => 401 ,:Message => 'You are not an authorised person to access this page' }
  end


end

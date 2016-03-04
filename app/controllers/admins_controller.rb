class AdminsController < ApplicationController
 before_action :check_if_admin
# before_filter :new ,:only => [:add_members] #execute new before add_members---factory pattern

#listing of all admin activites
 def index
 end

  #for admin to add members custom action
  def new
   @user = User.new
  end

 #send parameters to user model to create a new user by admin 
  def add_members
    @user = User.from_admin params
     if @user.present?
        redirect_to({ action: 'new' }, notice: "User has been created Successfully !!")
      else
        redirect_to({ action: 'new' })
      end 
  end

 def list
  @users = User.all
 end
  
 def remove
  @user = User.find_by_id(params["key"])
  @user.destroy 
  respond_to do |format|
   format.json { render json: @user }  # respond with the created JSON object
   end
 end

end

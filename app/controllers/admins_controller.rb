class AdminsController < ApplicationController
 before_action :check_if_admin
# before_filter :new ,:only => [:add_members] #execute new before add_members---factory pattern

#listing of all admin activites
 def index
 p "****************index #{params.inspect}"
 end

  #for admin to add members custom action
  def new
   @user = User.new
  end

  def admin_assign_roles
  if params.has_key?("admin_rol") && params.has_key?("user")
    if params['user'].has_key?("roles")
     @role ,@message  = Role.bulk_assignment_roles params
    end
  end
   if @message.present?
     @notice = @message
   elsif @role.present?
     @notice = "Roles has been assigned Successfully !!"
   end
   redirect_to({ action: 'index' }, notice: "#{@notice}")
 end
 
#def show

 #end

 #send parameters to user model to create a new user by admin 
  def add_members
    @user = User.from_admin params
     if @user.present?
        redirect_to({ action: 'new' } , notice: "User has been created Successfully !!")
       else
        redirect_to ({ action: 'new'} )
      end 
  end

 def list
  @users = User.all
 end

 def get_users
 @user = User.get_user(params['term'])
 respond_to do |format|
   format.json { render json: @user }  # respond with the created JSON object
   end
 end 
 
  def bulk_user_update
     User.bulk_edit @changed_date  if !(@changed_date = params["userchg"].to_a - params["userori"].to_a).empty?
    redirect_to({ action: 'list' })
  end
 
 def remove
  @user = User.find_by_id(params['key'])
  @user.destroy
  respond_to do |format|
     format.json { render json: @user }  # respond with the created JSON object
   end
 end
end

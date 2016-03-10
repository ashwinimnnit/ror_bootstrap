require 'bcrypt'
class User < ActiveRecord::Base
  include BCrypt
  has_many :authentications, class_name: 'UserAuthentication', dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable 
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable,:omniauth_providers => [:google_oauth2,:facebook]  
  has_one :profile, dependent: :destroy
  has_many :posts,  dependent: :destroy
  has_many :roles , dependent: :destroy
  after_create :set_profile
  
  scope :get_user, -> (parameter) { where("firstname LIKE ?", "#{parameter}%") }
  
  def self.create_from_omniauth(params)
    @user =  User.new(email:  params['info']['email'], firstname: params['info']['name'],
                     password:  Devise.friendly_token, confirmed_at: Time.now )
    @user.skip_confirmation! #don't send confirmation email to the user while signup with external devise like facebook or gmail
    @user.save
    @user.confirm!
    @user
  end

 # devise confirm! method overriden
  def confirm!
    welcome_message
    super
  end

  #creating a user by admin
  def self.from_admin (params)
   @user = User.new(email:  params['user']['email'], firstname: params['user']['firstname'] ,
                           lastname: params['user']['lastname'], password: "12345678" )
   @user.skip_confirmation!
   @response = @user.save
    if @response
    @user.send_reset_password_instructions
    Role.assignment_roles @user, params['user']['roles'] if !params['user']['roles'].empty? 
   end
  end

#  def self.from_omniauth(auth)
 #  where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
  # user.email = auth.info.email
  # user.password = Devise.friendly_token[0,20]
   #user.firstname = auth.info.name   # assuming the user model has a name
   #user.image = auth.info.image # assuming the user model has an image
    # end
  #end


  def self.new_with_session(params, session)
    super.tap do |user|
     if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
     end
    end
  end
 
 #admin changes the user details 
  def self.bulk_edit (data)
     @updated = data.to_h
     User.update(@updated.keys,@updated.values )
  end


   private
  # send welcome mails when user creates anew account
  def welcome_message
    UserMailer.welcome_message(self).deliver
  end
  
  def set_profile
  Profile.create(:fname => self.firstname, :lname => self.lastname ,:user_id => self.id)
  end
end

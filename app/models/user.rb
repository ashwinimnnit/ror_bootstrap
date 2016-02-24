class User < ActiveRecord::Base
  def self.create_from_omniauth(params)
    attributes = {
      email: params['info']['email'],
      firstname: params['info']['name'],
      password: Devise.friendly_token
    }

    create(attributes)
  end

  has_many :authentications, class_name: 'UserAuthentication', dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
        :omniauthable,:omniauth_providers => [:google_oauth2,:facebook]  
  has_many :posts


	def self.from_omniauth(auth)
  		where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
    		user.email = auth.info.email
    		user.password = Devise.friendly_token[0,20]
    		user.firstname = auth.info.name   # assuming the user model has a name
                #user.image = auth.info.image # assuming the user model has an image
  		end
	end


       def self.new_with_session(params, session)
    	super.tap do |user|
     	 if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
         user.email = data["email"] if user.email.blank?
        end
       end
      end


    # def self.from_omniauth(access_token)
     #  data = access_token.info
      # user = User.where(:email => data["email"]).first
       # Uncomment the section below if you want users to be created if they don't exist
       #unless user
        #  user = User.create(name: data["name"],
         #    email: data["email"],
          #   password: Devise.friendly_token[0,20]
         # )
     # end
     # user
    # end

end

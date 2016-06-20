require "bcrypt"
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
class User < ActiveRecord::Base
  include BCrypt
  extend Utils::OauthImage
  validates :firstname, :lastname, presence: true
  has_many :authentications,
           class_name: "UserAuthentication", dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers:  [:google_oauth2, :facebook]
  has_one :profile, dependent: :destroy
  has_many :posts,  dependent: :destroy
  has_many :roles
  after_create :set_profile
  has_many :receivers, class_name: "Notification", dependent: :destroy,
                       foreign_key: "user_id"
  has_many :senders, class_name: "Notification", foreign_key: "sender_id"
  # paperclip image upload gem method
  has_attached_file :avatar,
                    styles: { medium: "300x300>", thumb: "50x50>" },
                    path: "public/system/:class/:id/:style/:filename",
                    url: "/system/:class/:id/:style/:basename.:extension",
                    default_url: "/images/no-image.png"

  validates_attachment_content_type :avatar, content_type: /\Aimage/
  # before_save :extract_dimensions
  scope :has_firstname_as, -> (param) { where("firstname LIKE ?", "#{param}%").limit(5) }

  scope :has_email_as, -> (param) { where("email = ?", param) }

  def self.create_from_omniauth(params)
    fname, lname = split_names params
    @user = User.new(email:  params["info"]["email"],
                     firstname: fname,
                     lastname: lname,
                     avatar_file_name: "img.jpg",
                     password: params["info"]["email"],
                     confirmed_at: Time.now)
    # don"t send email to the user while signup with externa devise
    @user.skip_confirmation!
    @user.save
    @user
  end

  def self.split_names(param)
    if param["provider"] == "facebook"
      param["info"]["name"].split(" ", 2)
    elsif param["provider"] == "google_oauth2"
      [param["info"]["first_name"], param["info"]["last_name"]]
    end
  end

  # devise confirm! method overriden
  def confirm!
    welcome_message
    super
  end

  # creating a user by admin
  def self.create_user(params)
    user = User.new(email:  params["user"]["email"],
                    firstname: params["user"]["firstname"],
                    lastname: params["user"]["lastname"],
                    password: "12345678")
    user.skip_confirmation!
    user.save
    user
  end

  # creating user via api
  def self.create_user_from_api(param)
    create(email:  param["email"],
           firstname: param["firstname"],
           lastname: param["lastname"],
           password: param["password"])
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      fb_data = session["devise.facebook_data"]
      data = fb_data["extra"]["raw_info"] if fb_data
      user.email = data["email"] if data && user.email.blank?
    end
  end

  # admin changes the user details
  def self.bulk_edit(data)
    @updated = data.to_h
    User.update(@updated.keys, @updated.values)
  end

  def update_roles(roles)
    Role.assignment_roles(self, roles) if roles.present?
  end

  private

  # send welcome mails when user creates a new account
  def welcome_message
    UserMailer.welcome_message(self).deliver
  end

  def set_profile
    Profile.create(fname: firstname,
                   lname: lastname,
                   user_id: id)
  end
end

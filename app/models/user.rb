require 'bcrypt'
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
  has_many :authentications,
           class_name: 'UserAuthentication', dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers:  [:google_oauth2, :facebook]
  has_one :profile, dependent: :destroy
  has_many :posts,  dependent: :destroy
  has_many :roles, dependent: :destroy
  after_create :set_profile

  scope :listingUser, -> (param) { where('firstname LIKE ?', "#{param}%") }

  def self.create_from_omniauth(params)
    @user = User.new(email:  params['info']['email'],
                     firstname: params['info']['name'],
                     password:  Devise.friendly_token,
                     confirmed_at: Time.now)
    # don't send email to the user while signup with externa devise
    @user.skip_confirmation!
    @user.save
    @user.confirm!
    @user
  end

  # devise confirm! method overriden
  def confirm!
    welcome_message
    super
  end

  # creating a user by admin
  def self.from_admin(params)
    user = User.new(email:  params['user']['email'],
                    firstname: params['user']['firstname'],
                    lastname: params['user']['lastname'],
                    password: '12345678')
    user.skip_confirmation!
    begin
      user.save!
    rescue ActiveRecord::RecordInvalid => invalid
      user = invalid
    end
    begin
   rescue ActiveRecord::RecordNotUnique => invalid
     user = invalid
   end
    user
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      fb_data = session['devise.facebook_data']
      data = fb_data['extra']['raw_info'] if fb_data
      user.email = data['email'] if data && user.email.blank?
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

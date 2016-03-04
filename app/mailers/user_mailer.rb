class UserMailer < ActionMailer::Base  
 include Devise::Mailers::Helpers

   default from: 'noreply@talntica.com'

  #on registration via external servives like google or facebook etc.. 
  def welcome_message(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  end

end

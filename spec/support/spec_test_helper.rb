module SpecTestHelper
  def login_user
    login("dummy@dumm.com")
  end

  def login(user)
    user = User.where(email: user).first
    request.session[:user] = user.id
  end

  def current_user
    User.find(request.session[:user])
  end
end

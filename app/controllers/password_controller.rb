# comments
class PasswordController < Devise::PasswordsController
  def edit
    super
    user = resource_class.reset_password_by_token(params)
    if user.id
      expires_after = ((Time.now.utc - user.reset_password_sent_at) / 60).round
      if expires_after > 1
        render json: {
          status: 498,
          message: "token expired"
        }
      end
    else
      reset_password_token_invalid
    end
  end

  def reset_password_token_invalid
    render json: {
      status: 401,
      message: "reset password token is invalid"
    }
  end
end

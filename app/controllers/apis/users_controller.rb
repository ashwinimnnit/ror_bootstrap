module Apis
  class UsersController < ApiController
    def create_users
      diff = mandatory_keys mandatory_keys_for_signup
      if diff.empty?
        response = diff
        errors = "missing fields"
      else
        response = User.create_user_from_api params
        errors = response.errors.full_messages if response.errors.any?
      end
      render json: {
        message: response,
        errors: errors
      }
    end

    private

    def mandatory_keys_for_signup
      %w(firstname lastname email password)
    end
  end
end

# apis controller
module Apis
  class ApiController < ApplicationController
    skip_before_action :authenticate_user!
    protect_from_forgery with: :null_session
    before_action :set_params_hash, if: :request_is_get?

    private

    def set_params_hash
      splitted_params = params[:params].split("/")
      Hash[splitted_params.each_slice(2).to_a].each do |key, value|
        params[key.to_sym] = value
      end
      params.delete("params")
    end

    def render_403(response)
      render json: {
        status: 403,
        message: response.errors.messages
      }
    end

    def mandatory_keys(compulsory_keys)
      compulsory_keys - except_params.keys
    end

    def request_is_get?
      request.method == "GET" && !params["params"].nil?
    end

    def request_is_valid_post?
      request.method == "POST" && !except_params.empty?
    end

    def except_params
      params.except(:action,
                    :controller)
    end
  end
end

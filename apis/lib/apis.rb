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
  end
end

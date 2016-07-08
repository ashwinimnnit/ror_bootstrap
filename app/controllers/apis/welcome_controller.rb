module Apis
  class WelcomeController < ApiController
    layout false
    def index
      render "api_guide/guide"
    end
  end
end

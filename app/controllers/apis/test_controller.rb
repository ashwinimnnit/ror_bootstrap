# api module
module Apis
  class TestController < ApiController
    def hello
      render json: {
        message: "hieeee",
        param: params
      }
    end
  end
end

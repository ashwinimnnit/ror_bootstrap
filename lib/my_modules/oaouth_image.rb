# comment
require 'open-uri'
module MyModules
  # documetaion
  module OaouthImage
    def user_oaouth_image(user_image_uri)
      open(redirection_forbidden user_image_uri) do |f|
        File.open('whatever_file.jpg', 'wb') do |file|
          file.puts f.read
        end
      end
    end

    def redirection_forbidden(url)
    arr = url.split(':',2)
    'https:'+ arr[1]
    end

  end
end

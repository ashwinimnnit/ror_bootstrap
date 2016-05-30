# comment
require "open-uri"
require "net/http"
# documentaion
module Utils
  # documetaion
  module OauthImage
    def user_oaouth_image(user_image_uri, user)
      @count = 0
      path_array = make_directory user
      open(redirection_forbidden(user_image_uri)) do |f|
        @image = f.read
        path_array.each do |path|
          FileUtils.rm_rf(Dir.glob("#{path}/*"))
          @count += 1
          File.open(File.join(path, "img.jpg"), "wb") do |file|
            file.write @image
            crop_image(path) if @count == 1
          end
        end
      end
    end

    def crop_image(path)
      MiniMagick::Image.new("#{path}/img.jpg").resize "50x50"
    end

    def redirection_forbidden(url)
      arr = url.split(":", 2)
      "https:" + arr[1]
    end

    def make_directory(user)
      @array = []
      %w(thumb medium).each do |style|
        File.join(Rails.root, "public/system/users/#{user.id}/#{style}")
        @array << FileUtils
                  .mkdir_p(File.join(Rails
                  .root, "public/system/users/#{user.id}/#{style}"))[0]
      end
      @array
    end

    def facebook_api(url, user)
      uri = URI.parse(url)
      req = Net::HTTP::Get.new(uri.request_uri)
      res = Net::HTTP.start(uri.host, uri.port,
                            use_ssl: uri.scheme == "https") { |http| http.request req }
      response = JSON.parse(res.body)
      user_oaouth_image(response["data"]["url"], user) unless response.blank?
    end
  end
end

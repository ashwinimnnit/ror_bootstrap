json.array!(@posts) do |post|
  json.extract! post, :id, :subject, :description
  json.url post_url(post, format: :json)
end

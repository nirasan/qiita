json.array!(@tags) do |tag|
  json.extract! tag, :id, :body
  json.url tag_url(tag, format: :json)
end

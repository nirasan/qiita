json.array!(@edit_requests) do |edit_request|
  json.extract! edit_request, :id, :user_id, :entry_id, :body, :old_body
  json.url edit_request_url(edit_request, format: :json)
end

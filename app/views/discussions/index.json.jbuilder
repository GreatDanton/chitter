json.array!(@discussions) do |discussion|
  json.extract! discussion, :id, :content
  json.url discussion_url(discussion, format: :json)
end

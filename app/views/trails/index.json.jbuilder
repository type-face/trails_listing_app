json.array!(@trails) do |trail|
  json.extract! trail, :id, :city, :state, :country, :name, :unique_id, :directions, :lat, :lon, :activity_id
  json.url trail_url(trail, format: :json)
end

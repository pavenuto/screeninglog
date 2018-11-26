json.array!(@screenings) do |screening|
  json.extract! screening, :id, :date, :rating
  json.url screening_url(screening, format: :json)
end

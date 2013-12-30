json.array!(@directors) do |director|
  json.extract! director, :id, :first_name, :middle_name, :last_name
  json.url director_url(director, format: :json)
end

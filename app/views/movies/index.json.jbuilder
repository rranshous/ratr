json.array!(@movies) do |movie|
  json.extract! movie, :id, :title, :upvotes, :description
  json.url movie_url(movie, format: :json)
end

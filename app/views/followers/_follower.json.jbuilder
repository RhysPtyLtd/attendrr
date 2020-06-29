json.extract! follower, :id, :name, :email, :active, :created_at, :updated_at
json.url follower_url(follower, format: :json)

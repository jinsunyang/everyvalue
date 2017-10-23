json.extract! user, :id, :name, :nickname, :phone, :gender, :birth_date, :identity_provider, :is_authorized, :created_at, :updated_at
json.url user_url(user, format: :json)

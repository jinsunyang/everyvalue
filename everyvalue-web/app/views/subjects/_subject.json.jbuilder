json.extract! subject, :id, :title, :contents, :user_id, :user_nickname, :average_value, :created_at, :updated_at
json.url subject_url(subject, format: :json)

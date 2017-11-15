json.extract! comment, :id, :subject_id, :parent_id, :user_id, :user_nickname, :user_value, :contents, :created_at, :updated_at
json.url comment_url(comment, format: :json)

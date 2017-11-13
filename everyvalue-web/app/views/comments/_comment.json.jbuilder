json.extract! comment, :id, :subject_id, :user_id, :user_nickname, :contents, :created_at, :updated_at
json.url comment_url(comment, format: :json)

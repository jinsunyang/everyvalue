json.extract! reply, :id, :comment_id, :subject_id, :user_id, :user_nickname, :contents, :created_at, :updated_at
json.url reply_url(reply, format: :json)

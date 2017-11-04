json.extract! subject_attachment, :id, :subject_id, :content, :created_at, :updated_at
json.url subject_attachment_url(subject_attachment, format: :json)

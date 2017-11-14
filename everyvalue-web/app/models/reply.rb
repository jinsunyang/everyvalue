class Reply < ApplicationRecord
  belongs_to :comment
  belongs_to :subject
  belongs_to :user
end

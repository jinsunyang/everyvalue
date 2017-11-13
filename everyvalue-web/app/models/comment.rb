class Comment < ApplicationRecord
  belongs_to :subject
  belongs_to :user
end

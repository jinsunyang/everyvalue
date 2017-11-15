class Comment < ApplicationRecord
  belongs_to :subject
  belongs_to :user

  belongs_to :parent, foreign_key: 'parent_id', class_name: 'Comment'
  has_many :children, foreign_key: 'parent_id', class_name: 'Comment', dependent: :delete_all
end

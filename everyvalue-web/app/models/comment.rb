class Comment < ApplicationRecord
  belongs_to :subject
  belongs_to :user

  #belongs_to 나 has_many 로 구현하면 db로의 query가 너무 많아져서 직접 구현해야 할듯
  belongs_to :parent, foreign_key: 'parent_id', class_name: 'Comment'
  has_many :children, foreign_key: 'parent_id', class_name: 'Comment', dependent: :delete_all

  before_save :set_depth

  def set_depth
    self.depth = parent.depth + 1 if self.parent.present?
  end
end

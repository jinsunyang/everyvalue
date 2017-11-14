class Comment < ApplicationRecord
  belongs_to :subject
  belongs_to :user

  has_many :replies

  attr_accessor :searched_replies
end

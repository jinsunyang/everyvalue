class Subject < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :hashtags
  has_many :subject_attachments, dependent: :destroy
  has_many :valuations
  has_many :comments

  accepts_nested_attributes_for :subject_attachments, reject_if: proc { |attributes| attributes[:name].blank? }, allow_destroy: true

  def self.ransackable_attributes(auth_object = nil)
    #title_or_contents 이거는 type nil class 에러가 나고 있어서 일단 지움..
    %w(title contents user_nickname)
  end
end
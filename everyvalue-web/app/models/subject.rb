class Subject < ApplicationRecord
  belongs_to :user
  has_many :subject_attachments, dependent: :destroy
  accepts_nested_attributes_for :subject_attachments, reject_if: proc { |attributes| attributes[:name].blank? }, allow_destroy: true
end

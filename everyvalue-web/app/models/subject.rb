class Subject < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :hashtags
  has_many :subject_attachments, dependent: :destroy
  accepts_nested_attributes_for :subject_attachments, reject_if: proc { |attributes| attributes[:name].blank? }, allow_destroy: true

  def self.ransackable_attributes(auth_object = nil)
    %w(title_cont contents_cont title_or_contents_cont user_nickname) + _ransackers.keys
  end
end
class SubjectAttachment < ApplicationRecord
  belongs_to :subject

  #for using carrierwave
  mount_uploader :content, ContentUploader
end

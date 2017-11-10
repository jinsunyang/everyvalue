class RootController < ApplicationController
  # GET /subject_attachments
  # GET /subject_attachments.json
  def home
    @subjects = Subject.all
  end
end

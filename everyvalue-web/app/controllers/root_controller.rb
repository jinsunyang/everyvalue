class RootController < ApplicationController

  before_action :set_navbar_data, only: [:home]

  # GET /subject_attachments
  # GET /subject_attachments.json
  def home
  end

end
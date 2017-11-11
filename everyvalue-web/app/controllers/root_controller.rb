class RootController < ApplicationController
  # GET /subject_attachments
  # GET /subject_attachments.json
  def home
    @hashtags = Hashtag.all

    hashtag_id = params[:hashtag_id]
    #http://railscasts.com/episodes/370-ransack?view=asciicast
    @subjects =
        if hashtag_id.blank?
          Subject.all
        else
          Hashtag.find(hashtag_id).subjects rescue []
        end
  end
end
class RootController < ApplicationController
  # GET /subject_attachments
  # GET /subject_attachments.json
  def home
    @hashtags = Hashtag.all

    q = params[:q] || {}
    q[:selected_hashtag_hidden] = params[:hashtag_id] if params[:hashtag_id].present?

    @selected_subjects = subjects_by_ransack(q)
    @subjects = @selected_subjects.result
    @selected_subjects.build_condition if @selected_subjects.conditions.empty?
  end

  private
  def subjects_by_ransack(q)
    if q[:selected_hashtag_hidden].present?
      hashtag_id = q[:selected_hashtag_hidden]
      selected_hashtag = @hashtags.select { |s| s.id == hashtag_id.to_i }
      selected_hashtag.first.subjects.search(q) rescue Ransack::Search.new(Subject)
    else
      #http://railscasts.com/episodes/370-ransack?view=asciicast
      Subject.search(q)
    end
  end
end
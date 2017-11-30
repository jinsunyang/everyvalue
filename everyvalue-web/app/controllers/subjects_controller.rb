class SubjectsController < ApplicationController
  before_action :set_navbar_data, only: [:index, :show, :new, :edit]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]
  before_action :current_user, only: [:show]
  before_action :set_subject, only: [:show, :edit, :update, :destroy]
  before_action :set_hashtag_id, only: [:create, :update]

  # GET /subjects
  # GET /subjects.json
  def index
    @subjects = Subject.all
  end

  # GET /subjects/1
  # GET /subjects/1.json
  def show
    @comments = @subject.comments

    if @current_user
      @user_id = @current_user.id
      @user_nickname = @current_user.nickname
      user_valuation = @subject.valuations.where(user_id: @current_user.id).first
      @user_value_on_subject = user_valuation.price if user_valuation.present?
    end

    # replies = Reply.where(id: @comments.map(&:id))
    # @comments.each do |c|
    #   c.searched_replies = replies.select { |r| r.comment_id == c.id }
    # end
  end

  # GET /subjects/new
  def new
    @subject = Subject.new
    @subject_attachment = @subject.subject_attachments.build
  end

  # GET /subjects/1/edit
  def edit
  end

  # POST /subjects
  # POST /subjects.json
  def create
    puts "params : #{params}"

    @subject = Subject.new(subject_params)

    respond_to do |format|
      if @subject.save
        HashtagsSubject.create(hashtag_id: @hashtag_id, subject_id: @subject.id)
        subject_attachments = params[:subject_attachments]
        if subject_attachments.present? && subject_attachments['content'].present?
          subject_attachments['content'].each do |c|
            @subject.subject_attachments.create!(content: c)
          end
        end

        format.html { redirect_to @subject, notice: 'Subject was successfully created.' }
        format.json { render :show, status: :created, location: @subject }
      else
        format.html { render :new }
        format.json { render json: @subject.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /subjects/1
  # PATCH/PUT /subjects/1.json
  def update
    respond_to do |format|
      if @subject.update(subject_params)
        format.html { redirect_to @subject, notice: 'Subject was successfully updated.' }
        format.json { render :show, status: :ok, location: @subject }
      else
        format.html { render :edit }
        format.json { render json: @subject.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subjects/1
  # DELETE /subjects/1.json
  def destroy
    @subject.destroy
    respond_to do |format|
      format.html { redirect_to subjects_url, notice: 'Subject was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # def comment
  #   @comments = Subject.find(1).comments
  #
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subject
      @subject = Subject.find(params[:id])
    end

    def set_hashtag_id
      @hashtag_id = params[:subject][:hashtag_id]
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def subject_params
      params.require(:subject).permit(:title, :contents, :user_id, :user_nickname, :average_value)
    end
end

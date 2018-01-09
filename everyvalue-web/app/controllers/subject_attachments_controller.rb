class SubjectAttachmentsController < ApplicationController
  before_action :set_subject_attachment, only: [:show, :edit, :update, :destroy]

  # GET /subject_attachments
  # GET /subject_attachments.json
  def index
    @subject_attachments = SubjectAttachment.all
  end

  # GET /subject_attachments/1
  # GET /subject_attachments/1.json
  def show
  end

  # GET /subject_attachments/new
  def new
    @subject_attachment = SubjectAttachment.new
  end

  # GET /subject_attachments/1/edit
  def edit
  end

  # POST /subject_attachments
  # POST /subject_attachments.json
  def create
    puts "params : #{params}"
    puts "subject_attachment_params : #{subject_attachment_params}"

    @subject_attachment = SubjectAttachment.new(subject_attachment_params)

    puts "content : #{@subject_attachment.content}"

    # render text: 'http://naver.com'
    render json: { url: @subject_attachment.content, content_id: @subject_attachment.id } if @subject_attachment.save

    # respond_to do |format|
    #   if @subject_attachment.save
    #     format.html { redirect_to @subject_attachment, notice: 'Subject attachment was successfully created.' }
    #     format.json { render :show, status: :created, location: @subject_attachment }
    #     render text: @subject_attachment.content
    #   else
    #     format.html { render :new }
    #     format.json { render json: @subject_attachment.errors, status: :unprocessable_entity }
    #     render text: 'http://www.naver.com'
    #   end
    # end
  end

  # PATCH/PUT /subject_attachments/1
  # PATCH/PUT /subject_attachments/1.json
  def update
    respond_to do |format|
      if @subject_attachment.update(subject_attachment_params)
        format.html { redirect_to @subject_attachment, notice: 'Subject attachment was successfully updated.' }
        format.json { render :show, status: :ok, location: @subject_attachment }
      else
        format.html { render :edit }
        format.json { render json: @subject_attachment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /subject_attachments/1
  # DELETE /subject_attachments/1.json
  def destroy
    @subject_attachment.destroy
    respond_to do |format|
      format.html { redirect_to subject_attachments_url, notice: 'Subject attachment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subject_attachment
      @subject_attachment = SubjectAttachment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def subject_attachment_params
      params.require(:subject_attachment).permit(:subject_id, :content)
    end
end

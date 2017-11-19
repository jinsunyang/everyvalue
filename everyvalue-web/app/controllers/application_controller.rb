class ApplicationController < ActionController::Base
  # before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception

  before_action :set_paginate_option, only: [:index, :home]


  protected
  def authenticate_user!
    if user_signed_in?
      #그냥 current_user 하면 user session 을 통해 user객체 나오는듯.
      super
    else
      #status: 404 옵션을 넣으면 redirect가 되지 않는다. redirect 될 때의 http status code는 30x 인데, 404를 내려주면서 redirect하면 redirect가 되지 않는다.
      redirect_back(fallback_location: root_path, alert: '로그인 후 이용해 주세요.')
      # redirect_to new_user_session_path, notice: '로그인 후 이용해 주세요.'
      ## if you want render 404 page
      ## render :file => File.join(Rails.root, 'public/404'), :formats => [:html], :status => 404, :layout => false
    end
  end

  def set_current_user
    @current_user = current_user
  end

  def set_paginate_option
    @page = params[:page] || 1
    @per = params[:per] || 5
  end
end

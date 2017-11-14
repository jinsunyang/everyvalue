class ApplicationController < ActionController::Base
  # before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception

  before_action :set_paginate_option, only: [:index, :home]

  def set_paginate_option
    @page = params[:page] || 1
    @per = params[:per] || 5
  end
end

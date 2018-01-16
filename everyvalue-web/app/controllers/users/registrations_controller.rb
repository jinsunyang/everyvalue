class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters
  before_action :check_recaptcha, only: [:create]
  before_action :set_navbar_data, only: [:new]

  def new
    super
  end

  #override for handing ActiveRecord::RecordNotUnique exception
  def create
    begin
      build_resource(sign_up_params)

      resource.save
      yield resource if block_given?
      if resource.persisted?
        if resource.active_for_authentication?
          set_flash_message! :notice, :signed_up
          sign_up(resource_name, resource)
          respond_with resource, location: after_sign_up_path_for(resource)
        else
          set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
          expire_data_after_sign_in!
          respond_with resource, location: after_inactive_sign_up_path_for(resource)
        end
      else
        clean_up_passwords resource
        set_minimum_password_length
        respond_with_navigational(resource) { render :new }
      end
    rescue ActiveRecord::RecordNotUnique => e
      clean_up_passwords resource
      set_minimum_password_length

      #Duplicate entry 'abcde' for key 'index_users_on_nickname' e.cause string split -> get attribute key
      error_causing_attribute_name = e.cause.message.split('index_users_on_')[1]
      resource.errors.add(error_causing_attribute_name.to_sym, 'is duplicate')

      respond_with_navigational(resource) { render :new }
    end
  end

  private
  def check_recaptcha
    unless verify_recaptcha
      self.resource = resource_class.new sign_up_params
      resource.validate
      respond_with_navigational(resource) { render :new }
    end
  end

  protected
  def configure_permitted_parameters
    added_attrs = [:name, :nickname, :email, :password, :password_confirmation]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    # devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
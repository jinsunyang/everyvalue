class Users::SessionsController < Devise::SessionsController
  before_action :configure_permitted_parameters

  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)
    yield resource if block_given?
    respond_with resource, location: after_sign_in_path_for(resource)
  end

  protected
  def configure_permitted_parameters
    #여기서 name을 넣어주지 않으니, login 시의 lockable 동작으로 failed_attempts 값을 올리는 로직도 동작하지 않음. 추가하니 동작.
    # >>> 이거 아닌듯.. 그냥 됨. 이거 추가하든 안하든..
    added_attrs = [:name, :nickname, :email, :password, :password_confirmation]
    devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
  end
end


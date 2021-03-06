class Users::RegistrationsController < Devise::RegistrationsController
  skip_before_action :require_no_authentication
  before_action :configure_sign_up_params, only: :create
  before_action :configure_account_update_params, only: :update

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit :sign_up,
      keys: [:name, :email, :password]
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit :account_update,
      keys: [:name, :address, :phone, :password]
  end
end

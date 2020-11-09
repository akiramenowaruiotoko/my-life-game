class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  private
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :free_time, :private])
    devise_parameter_sanitizer.permit(:account_update, keys: [:nickname, :free_time, :private_mode])
  end
end

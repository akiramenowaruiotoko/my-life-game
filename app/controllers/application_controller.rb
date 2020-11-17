class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!, except: [:index, :show]

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :free_time, :private_mode])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :free_time, :private_mode])
  end
end

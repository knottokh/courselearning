class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  before_action :toeidtorroot, if: :authenticate_user!
  protected
 
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
    if current_user and !current_user[:provider].nil?
      devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name])
    else
      devise_parameter_sanitizer.permit(:account_update, keys: [:password,:password_confirmation,:first_name, :last_name,:email])
    end
    #devise_parameter_sanitizer.for(:sign_up) << [:first_name, :last_name]
  end
  def toeidtorroot
      if (current_user[:first_name].nil? or 
          current_user[:first_name].empty?) or  
          (current_user[:last_name].nil? or 
            current_user[:last_name].empty?)
         redirect_to edit_user_registration_path   
      #else 
      #  redirect_to root_path
      end
  end
end

class CallbacksController < Devise::OmniauthCallbacksController
  #def facebook
  #  @user = User.from_omniauth(request.env["omniauth.auth"])
  #  sign_in_and_redirect @user
  #end
  def facebook
      #@user = User.create_from_provider_data(request.env['omniauth.auth'])
      @user = User.from_omniauth(request.env["omniauth.auth"])
      if @user.persisted?
        sign_in_and_redirect @user
        set_flash_message(:notice, :success, kind: 'Facebook') if is_navigational_format?
      else
        flash[:error] = 'There was a problem signing you in through Facebook. Please register or try signing in later.'
        redirect_to new_user_registration_url
      end 
    end
end

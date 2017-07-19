class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

#  before_action :store_current_location, :unless => :devise_controller?

  #private
    # override the devise helper to store the current location so we can
    # redirect to it after loggin in or out. This override makes signing in
    # and signing up work automatically.
  #  def store_location
  #    store_location_for(:user, articles_path)
  #  end

  private
    # override the devise method for where to go after signing out because theirs
    # always goes to the root path. Because devise uses a session variable and
    # the session is destroyed on log out, we need to use request.referrer
    # root_path is there as a backup
  def after_sign_in_path_for(resource)
    if resource.is_a?(User)
      articles_feed_path(current_user.id)
  else
    super
  end
  end


 def configure_permitted_parameters
   devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name, :avatar, :avatar_cache, :remove_avatar, :new_comments])
   devise_parameter_sanitizer.permit(:account_update, keys: [:last_name, :first_name, :email, :password, :password_confirmation, :current_password, :avatar, :avatar_cache, :remove_avatar, :new_comments])
 end

end

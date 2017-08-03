class Users::SessionsController < Devise::SessionsController
# before_action :configure_sign_in_params, only: [:create]
layout "landing", :only => [ :new ]

  def new
    super
    User.new
  end

  def create
    super
  end

  def destroy
    super
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  private

   def configure_sign_in_params
     devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute, :last_name, :user, :first_name, :email, :password, :password_confirmation, :home_views, :avatar, :avatar_cache, :remove_avatar, :new_comments])
   end

end

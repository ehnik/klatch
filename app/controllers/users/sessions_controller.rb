class Users::SessionsController < Devise::SessionsController
# before_action :configure_sign_in_params, only: [:create]

    def new
      super
    User.new
    redirect_to articles_path
  end

  def create
    super
    User.create!(user_params)
    redirect_to articles_path
  end

  def destroy
    super
    redirect_to "/users/sign_up"
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
     devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute], user_params)
   end
end

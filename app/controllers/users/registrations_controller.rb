class Users::RegistrationsController < Devise::RegistrationsController
# before_action :configure_sign_up_params, only: [:create]
# before_action :configure_account_update_params, only: [:update]
  layout "landing", :only => [ :new ]

  def new
     super
     User.new
     puts "new controller"
  end

  def create
    if User.where(email: params[:user][:email]).length>0
      flash[:alert] = "This email has already been registered."
      redirect_back fallback_location: new_user_session_path
    else
      super
      firstName = @user.first_name.split.map(&:capitalize).join(' ')
      lastName = @user.last_name.slice(0,1).capitalize + @user.last_name.slice(1..-1)
      @user.update!(first_name: firstName,
      last_name: lastName)
      if @user.avatar==nil
        @user.update!(avatar: default.jpg)
      end
    end
  end

  # GET /resource/edit
  def edit
     super
   end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  def destroy
    friends1 = Friendship.where(user_id:current_user.id).pluck(:id).uniq
    friends2 = Friendship.where(friend_id:current_user.id).pluck(:id).uniq
    request1 = Request.where(requester_id:current_user.id).pluck(:id).uniq
    request2 = Request.where(requestee_id:current_user.id).pluck(:id).uniq
    comment1 = Comment.where(sender_id: current_user.id).pluck(:id).uniq
    comment2 = Comment.where(user_id: current_user.id).pluck(:id).uniq
    articles = Article.where(user_id: current_user.id).pluck(:id).uniq
    Friendship.delete((friends1+friends2))
    puts "friends"
    Request.delete((request1+request2))
    puts "requests"
    Comment.delete((comment1+comment2))
    puts "comments"
    Article.delete(articles)
     super
   end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  #def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
  private

    def
    def user_params
      params.permit(:sign_up, keys: [:last_name, :user, :first_name, :email, :password, :password_confirmation, :home_views, :avatar, :avatar_cache, :remove_avatar, :new_comments])
    end
end

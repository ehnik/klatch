class FriendshipsController < ApplicationController

  def new
    @user = current_user
    if params[:search]
      @users = User.search(params[:search]).order("created_at DESC")
    end
  end

  def show
    @user = current_user
    if params[:search]
      @users = User.search(params[:search]).order("created_at DESC")
    end
  end

  def add
    if Friendship.where(:user_id => current_user.id, :friend_id => params[:friend_id]).exists?
      flash[:notice] = "You are already friends with #{User.find(params[:friend_id]).name}"
    else
    Friendship.create!(:user_id => current_user.id, :friend_id => params[:friend_id])
    flash[:notice] = "You are now friends with #{User.find(params[:friend_id]).name}"
    end
    redirect_to "/user/:user_id/friendships/new"
  end

  def create
    @user = current_user
    if params[:search]
      @users = User.search(params[:search]).order("created_at DESC")
    end
    redirect_to "/user/:user_id/friendships/new"
  end

private
def friendship_params
  params.require(:comment).permit!
end
end

class FriendshipsController < ApplicationController

  def show
    @user = current_user
    if params[:search]
      @users = User.search(params[:search]).order("created_at DESC")
    end
  end

  def add
    if Friendship.find_by_user_id_and_friend_id(current_user.id,params[:friend_id])!=nil
      flash[:notice] = "You are already friends with #{User.find(params[:friend_id]).name}"
    else
    Friendship.create!(:user_id => current_user.id, :friend_id => params[:friend_id])
    flash[:notice] = "You are now friends with #{User.find(params[:friend_id]).name}"
    end
    if params[:request]=="true"
      puts "friendship add method is being run with request functionality"
      request=Request.find_by_requestee_id_and_requester_id(current_user.id,params[:friend_id])
      Request.delete(request.id)
    end
    redirect_to "/user/#{current_user.id}/friendships/"
  end

  def destroy
    friendship = Friendship.find_by_user_id_and_friend_id(params[:user_id], params[:friend_id])
    friend = User.find(params[:friend_id])
    Friendship.delete(friendship.id)
    flash[:notice] = "You are no longer friends with #{friend.name}"
    redirect_to "/user/#{current_user.id}/friendships/"
  end

  def create
    @user = current_user
    if params[:search]
      @users = User.search(params[:search]).order("created_at DESC")
    end
    redirect_to "/user/#{current_user.id}/friendships/new"
  end

  private
    def friendship_params
      params.require(:comment).permit!
    end
end

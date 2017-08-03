class FriendshipsController < ApplicationController

  def show
    @user = current_user
    if params[:search]
      @users = User.search(params[:search]).order("created_at DESC")
    end
  end

  def add
    if Friendship.find_by_user_id_and_friend_id(current_user.id,params[:friend_id])!=nil && Friendship.find_by_user_id_and_friend_id(params[:friend_id],current_user.id)!=nil
      flash[:notice] = "You are already friends with #{User.find(params[:friend_id]).first_name} #{User.find(params[:friend_id]).last_name}"
    else
    friend = User.find(params[:friend_id])
    Friendship.create!(user: current_user, friend: friend)
    Friendship.create!(user: friend, friend: current_user)
    flash[:notice] = "You are now friends with #{User.find(params[:friend_id]).first_name} #{User.find(params[:friend_id]).last_name}"
    end
    if params[:request]=="true"
      request=Request.find_by_requestee_id_and_requester_id(current_user.id,params[:friend_id])
      Request.delete(request.id)
    end
    redirect_to requests_index_path
    end

  def destroy
    friendship1 = Friendship.find_by_user_id_and_friend_id(params[:user_id], params[:friend_id])
    friendship2 = Friendship.find_by_user_id_and_friend_id(params[:friend_id], params[:user_id])
    friend = User.find(params[:friend_id])
    Friendship.delete(friendship1.id)
    Friendship.delete(friendship2.id)
    friendComments = current_user.comments.where(sender_id: friend.id)
    userComments = friend.comments.where(sender_id: current_user.id)
    if friendComments.length>0
      friendComments.each do |comment|
        Comment.delete(comment.id)
      end
    end
    if userComments.length>0
      userComments.each do |comment|
        Comment.delete(comment.id)
      end
    end
    flash[:notice] = "You are no longer friends with #{friend.first_name} #{friend.last_name}"
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

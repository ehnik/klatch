class RequestsController < ApplicationController

  def index
    @user = current_user
    @requests = Request.where(requestee_id: @user.id)
  end

  def show
    @user = current_user
    @requests = Request.find(params[:id])
  end

  def destroy
    Request.delete(params[:id])
    redirect_to requests_index_path(current_user.id)
  end

  def new
    @request = Request.new
  end

  def create
    @request = Request.create!(request_params)
    flash[:notice] = "You have sent a friend request to #{User.find(params[:requestee_id]).name}"
    redirect_to "/user/#{current_user.id}/friendships/"
  end

  private
    def request_params
      params.permit(:message,:requestee_id,:requester_id)
    end
end

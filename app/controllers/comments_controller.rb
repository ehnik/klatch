class CommentsController < ApplicationController

  def create
    receiver = User.find(params[:user_id])
    puts receiver.first_name
    @comment = receiver.comments.create!(sender_id: current_user.id, content: params[:comment][:content], article_id: params[:article_id])
    currentComments = receiver.new_comments + 1
    receiver.update(new_comments: currentComments)
    flash[:notice] = "Your message was sent to #{User.find(receiver.id).first_name} #{User.find(receiver.id).last_name}"

    redirect_to articles_feed_path
  end

  def index
    @user = current_user
    @user.update(new_comments: 0)
    @sentComments = Comment.where(sender_id: current_user.id)
  end

  private
  def comment_params
   params.permit(:article_id, :content, :comment, :sender_id, :user_id)
  end

end

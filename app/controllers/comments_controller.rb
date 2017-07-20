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
    feedArticles = @sentComments.pluck(:article_id).uniq
    #^^creates array of article IDs that user has commented on
    userArticles = current_user.comments.pluck(:article_id).uniq
    #creates array of user article IDs that other users have commented on
    allArticles = userArticles + feedArticles
    @articles = Article.where(id: allArticles)
    puts @articles
  end

  private
  def comment_params
   params.permit(:article_id, :content, :comment, :sender_id, :user_id)
  end

end

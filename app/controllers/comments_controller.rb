class CommentsController < ApplicationController

  def feedCreate
    receiver = User.find(params[:user_id])
    puts receiver.first_name
    @comment = receiver.comments.create!(sender_id: current_user.id, content: params[:comment][:content], article_id: params[:article_id], new_reply:true)
    currentComments = receiver.new_comments + 1
    receiver.update(new_comments: currentComments)
    flash[:notice] = "Your message was sent to #{User.find(receiver.id).first_name} #{User.find(receiver.id).last_name}"

    redirect_to articles_feed_path
  end

  def discussionCreate
    receiver = User.find(params[:user_id])
    @comment = receiver.comments.create!(sender_id: current_user.id, content: params[:comment][:content], article_id: params[:article_id], new_reply:true)
    currentComments = receiver.new_comments + 1
    receiver.update(new_comments: currentComments)
    flash[:notice] = "Your message was sent to #{User.find(receiver.id).first_name} #{User.find(receiver.id).last_name}"

    redirect_to comments_index_path
  end

  def index
    @comment = Comment.new
    @user = current_user
    @user.update(new_comments: 0)
    notMyArticles = Article.where.not(user_id: current_user.id)
    notMyArticlesIds = notMyArticles.pluck(:id).uniq
    @feedComments = Comment.where({sender_id: current_user.id, article_id: notMyArticlesIds})
    feedArticles = @feedComments.pluck(:article_id).uniq
    @userArticles = Article.where(user_id: current_user.id)
    @feedArticles = Article.where(id: feedArticles)
    @newComments = @user.comments.where(new_reply:true)
    if params[:threadClicked]
      idArray = params[:threadClicked].split("-")
      puts idArray
      articleID = idArray[0]
      puts articleID
      senderID = idArray[1]
      puts senderID
      commentsToChange = @user.comments.where({sender_id: senderID,article_id: articleID,new_reply:true}).update_all(new_reply:false)
    end
  end

  private
  def comment_params
   params.permit(:article_id, :content, :comment, :sender_id, :user_id)
  end

end

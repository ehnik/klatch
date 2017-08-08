class ArticlesController < ApplicationController

  require 'uri'

  def index
    @user = current_user
    render :template => "articles/index"
  end

  def feed
    @backdate = 24
    @user = current_user
    @feedArticles = 0
    @comment = Comment.new
    @friends = Friendship.where(user_id: current_user.id)
    friendArray = @friends.pluck(:friend_id)
    articlesUnsorted = Article.where({user_id: friendArray})
    @articles = articlesUnsorted.order(created_at: :desc)
    @feedArticles = @articles.length

    render :template => "articles/feed"

    #@friends = Friendship.all
             #number of hours back that articles are shown
  end

  def new
    @article = Article.new
  end

  def create
    begin
      uri = URI(params[:article][:link])
        if uri.scheme=="https" || uri.scheme=="http"
          @article = current_user.articles.create!(article_params)
          @article.makeThumbnail
        else
          flash[:alert] = "Please enter URL in correct format with http:// or https:// prefix"
        end
    rescue
      puts "rescued!"
      flash[:alert] = "URL invalid. Please enter a valid URL."
    end
    redirect_to articles_index_path
  end

  def edit
    @article = Article.find(params[:id])
  end

  def destroy
    Article.delete(params[:id])
    redirect_to articles_index_path
  end

  def update
    @article = Article.find(params[:id])
    @article.update!(article_params)
    redirect_to articles_index_path
  end

  private
  def article_params
   params.require(:article).permit(:link, :message, :id, :title, :description, :pic_url, :created_at)
  end

end

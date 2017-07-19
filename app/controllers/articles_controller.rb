class ArticlesController < ApplicationController


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
    puts @friends
    puts "inbetween"
    friendArray = @friends.pluck(:friend_id)
    articlesUnsorted = Article.where({user_id: friendArray})
    @articles = articlesUnsorted.order(created_at: :desc)
    @feedArticles = @articles.length
    puts @feedArticles


    render :template => "articles/feed"

    #@friends = Friendship.all
             #number of hours back that articles are shown
  end

  def new
    @article = Article.new
  end

  def create
    @article = current_user.articles.create!(article_params)
    @article.makeThumbnail
    redirect_to articles_index_path
  end

  def edit
    @article = Article.find(params[:id])
  end

  def destroy
    Article.delete(params[:id])
    puts "destroyed!"
    redirect_to articles_index_path
  end

  def update
    @article = Article.find(params[:id])
    @article.update!(article_params)
    redirect_to articles_index_path
  end

  private
  def article_params
   params.require(:article).permit(:link, :message, :id, :title, :description, :pic_url)
  end

end

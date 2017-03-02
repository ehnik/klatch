class ArticlesController < ApplicationController

  def index
    @backdate = 24
    @user = current_user

    #@friends = Friendship.all
             #number of hours back that articles are shown
  end

  def new
    @article = Article.new
  end

  def create
    @article = current_user.articles.create!(article_params)
  end


  def edit
    @article = Article.find(:id)
  end

  def update
    @article = Article.find(:id)
    @article.update!(article_params)
  end

end

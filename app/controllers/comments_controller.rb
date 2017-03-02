class CommentsController < ApplicationController

  def create
    @article = Article.find(:id)
    @comment = @article.comments.create!(comment_params)
  end

  def new
    @article = Article.find(:id)
    @comment = @article.comments.new
  end
end

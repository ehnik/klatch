class Article < ApplicationRecord
  require 'uri'

  belongs_to :user
  has_many :comments

  def makeThumbnail
    begin
      object = LinkThumbnailer.generate(self.link)
    rescue LinkThumbnailer::Exceptions => e
      object = nil
    end

    if object !=nil
      puts object.description

      if object.description.length > 300
        $description = object.description.truncate(300, separator: ' ')
      else
        $description = object.description
      end
      if object.title.length > 200
        $title = object.title.truncate(200, separator: ' ')
      else
        $title = object.title
      end
        self.update!(title: $title, description: $description, pic_url: object.images.first.src.to_s)
    else
        self.update!(title: self.link, description: nil, pic_url: nil)
    end

  end

  def valid_url
    puts self.link
      begin
        uri = URI(self.link)
      rescue
        puts "rescued!"
        flash[:alert] = "URL invalid. Please enter a valid URL."
        return false
      end
      puts uri.scheme
      if uri.scheme=="http" || uri.scheme=="https"
        puts "boooo"
        return false
      else
        puts "yayyyy"
        return true
      end
  end

  def getCommenterIds(current_user)
    articleCommenterIds = self.comments.pluck(:sender_id).uniq
    if articleCommenterIds.include?(current_user.id)==true
      index = articleCommenterIds.index(current_user.id)
      articleCommenterIds.slice!(index)
    end
    return articleCommenterIds
  end

  def getCommenterNames(current_user)
    names = []
    articleCommenterIds = self.comments.pluck(:sender_id).uniq
    if articleCommenterIds.include?(current_user.id)==true
      index = articleCommenterIds.index(current_user.id)
      articleCommenterIds.slice!(index)
    end
    articleCommenterIds.each do |id|
      user = User.find(id)
      names.push({first: user.firstName, last: user.lastName})
    end
    return names
  end

  def getCommenterIdsFeed(current_user)
    discussers = self.comments.where(sender_id: current_user.id).pluck(:user_id).uniq
    return discussers
  end


  def showComments(sender_id)
    if self.comments.length > 0
      $userComments = self.comments.where(sender_id: sender_id)
      $userComments.order(created_at: :desc)
      return $userComments
    else
      return nil
    end
  end

  def commentsForUserArticle(sender_id, current_user)
      article = Article.find(self.id)
      commentArray = article.comments.where(sender_id: sender_id).or(article.comments.where({sender_id: current_user.id, user_id: sender_id}))
      $comments = commentArray.order(:created_at)
    return $comments
  end

  def commentsForFeed(current_user, sender_id)
    article = Article.find(self.id)
    commentArray = article.comments.where({sender_id: current_user.id, user_id: sender_id}).or(article.comments.where({sender_id: sender_id, user_id: current_user.id}))
    $comments = commentArray.order(:created_at)
    return $comments
  end


  def convertTime
    if self.created_at.strftime("%d/%m/%Y") == DateTime.now.strftime("%d/%m/%Y")
      $articleConverted = self.created_at.strftime("%l:%M %p")
    elsif self.created_at.strftime("%Y") == DateTime.now.strftime("%Y")
      $articleConverted = self.created_at.strftime("%B %e")
    else
      $articleConverted = self.created_at.strftime("%B %Y")
    end
    return $articleConverted
  end

end

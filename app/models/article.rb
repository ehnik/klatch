class Article < ApplicationRecord

  belongs_to :user
  has_many :comments

  def makeThumbnail
    puts self.link
    begin
      object = LinkThumbnailer.generate(self.link)
      puts object
    rescue LinkThumbnailer::Exceptions => e
      object = nil
    end
    if object !=nil
      self.update(title: object.title, description: object.description, pic_url: object.images.first.src.to_s)
      puts "updated"
    else
      puts "not updated"
      self.update(title: self.link)
    end
  end

end

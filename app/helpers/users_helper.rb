module UsersHelper
  def avatar_for(user,options = { size: 50})
    size = options[:size]
    if user.avatar?
      image_tag user.avatar.url(:thumb), :class => "feed_avatar"
    else
      image_tag "default.jpg", size: size, :class => "feed_avatar"
    end
  end
end

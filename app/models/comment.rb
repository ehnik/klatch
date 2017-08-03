class Comment < ApplicationRecord

  belongs_to :article
  belongs_to :user

  def convertTime
    if self.created_at.strftime("%d/%m/%Y") == DateTime.now.strftime("%d/%m/%Y")
      $commentConverted = self.created_at.strftime("%l:%M %p")
    elsif self.created_at.strftime("%Y") == DateTime.now.strftime("%Y")
      $commentConverted = self.created_at.strftime("%B %e")
    else
      $commentConverted = self.created_at.strftime("%B %Y")
    end
    return $commentConverted
  end

  def checkIfFriendSent(user)
    if user.friends.pluck(:id).uniq.include?(self.sender_id)
      return true
    else
      return false
    end
  end

end

class User < ApplicationRecord
  has_many :articles
  has_many :comments
  has_many :friendships
  has_many :friends, through: :friendships
  has_many :requests
  has_many :requesters, through: :requests

  mount_uploader :avatar, AvatarUploader

  #has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  #has_many :inverse_friends, :through => :inverse_friendships, :source => :user
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

   validates_integrity_of  :avatar
   validates_processing_of :avatar

  private
    def avatar_size_validation
      errors[:avatar] << "should be less than 500KB" if avatar.size > 0.5.megabytes
    end

  def self.search(search)
    where("CONCAT_WS(' ', first_name, last_name) ILIKE ? OR first_name ILIKE ? OR last_name ILIKE ?", "%#{search}%", "%#{search}%", "%#{search}%")
  end

end

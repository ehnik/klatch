class User < ApplicationRecord
  has_many :articles
  has_many :comments
  has_many :friendships
  has_many :friends, through: :friendships
  has_many :requests
  has_many :requesters, through: :requests

  #has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  #has_many :inverse_friends, :through => :inverse_friendships, :source => :user
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def self.search(search)
    where("name ILIKE ?", "%#{search}%")
  end

end

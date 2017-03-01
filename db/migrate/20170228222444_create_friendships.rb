class CreateFriendships < ActiveRecord::Migration[5.0]
  def change
    create_table :friendships do |t|
      t.belongs_to :user
      t.belongs_to :friend, class_name: "User"
    end
  end
end

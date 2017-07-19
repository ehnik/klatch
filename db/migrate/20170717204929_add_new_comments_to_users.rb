class AddNewCommentsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :new_comments, :integer
  end
end

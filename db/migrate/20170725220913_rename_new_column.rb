class RenameNewColumn < ActiveRecord::Migration[5.0]
  def change
    rename_column :comments, :new, :new_reply
  end
end

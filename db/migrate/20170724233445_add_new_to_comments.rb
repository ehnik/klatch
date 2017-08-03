class AddNewToComments < ActiveRecord::Migration[5.0]
  def change
    add_column :comments, :new, :boolean
  end
end

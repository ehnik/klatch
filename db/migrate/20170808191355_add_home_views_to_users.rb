class AddHomeViewsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :home_views, :boolean
  end
end

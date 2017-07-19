class AddTitleToArticles < ActiveRecord::Migration[5.0]
  def change
    add_column :articles, :title, :string
    add_column :articles, :description, :string
    add_column :articles, :pic_url, :string
  end
end

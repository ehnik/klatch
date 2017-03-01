class CreateArticles < ActiveRecord::Migration[5.0]
  def change
    create_table :articles do |t|
      t.string :link
      t.string :message
      t.belongs_to :user
      t.timestamps null: false
    end
  end
end

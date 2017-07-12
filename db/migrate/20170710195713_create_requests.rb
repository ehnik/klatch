class CreateRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :requests do |t|
      t.belongs_to :requestee, class_name: "User"
      t.belongs_to :requester, class_name: "User"
    end
  end
end

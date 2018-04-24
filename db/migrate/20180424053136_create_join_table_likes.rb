class CreateJoinTableLikes < ActiveRecord::Migration[5.1]
  def change
    create_join_table :users, :photos, table_name: :likes do |t|
      # t.index [:user_id, :photo_id]
      t.index [:photo_id, :user_id]
    end
  end
end

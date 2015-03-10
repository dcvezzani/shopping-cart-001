class AddUserIdToPurchases < ActiveRecord::Migration
  def change
    add_column :purchases, :user_id, :integer

    add_index :purchases, :user_id
  end
end

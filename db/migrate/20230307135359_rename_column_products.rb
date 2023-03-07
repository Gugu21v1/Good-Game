class RenameColumnProducts < ActiveRecord::Migration[7.0]
  def change
    rename_column :products, :user_id, :users_id
  end
end

class RemoveColumnEmailFromProducts < ActiveRecord::Migration[7.0]
  def change
    remove_column :products, :email
  end
end

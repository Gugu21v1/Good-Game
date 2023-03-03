class AddDetailsToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :details, :text
  end
end

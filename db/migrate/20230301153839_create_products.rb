class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :size
      t.string :name
      t.string :type
      t.text :description
      t.boolean :status, default: false

      t.timestamps
    end
  end
end

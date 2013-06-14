class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :photo
      t.integer :product_id
      t.string :producer_name
      t.string :primary_category
      t.string :secondary_category
      t.integer :volume_in_milliliters
      t.integer :price
      t.integer :alcohol_content
      t.boolean :is_kosher

      t.timestamps
    end
  end
end

class CreateBasket < ActiveRecord::Migration[7.1]
  def change
    create_table :basket_products do |t|
      t.integer :user_id
      t.integer :product_id
      t.integer :amount

      t.timestamps
    end
  end
end

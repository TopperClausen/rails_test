class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.integer :user_id
      t.timestamps
    end

    create_table :ordered_products do |t|
      t.integer :order_id
      t.integer :product_id
      t.integer :baught_price


      t.timestamps
    end
  end
end

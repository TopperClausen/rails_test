class Apikeys < ActiveRecord::Migration[7.1]
  def change
    create_table :apikeys do |t|
      t.string :key
    end

    add_index :apikeys, :key
  end
end

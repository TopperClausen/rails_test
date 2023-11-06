class CreateUsersTable < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :full_name
      t.string :email
      t.string :password_digest

      t.timestamps
    end

    add_index :users, :email
  end
end

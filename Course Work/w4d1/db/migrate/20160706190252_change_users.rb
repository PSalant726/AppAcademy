class ChangeUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      remove_column :users, :name
      remove_column :users, :email

      t.text :users, :username, null: false

    end

    add_index :users, :username, unique: true

  end
end

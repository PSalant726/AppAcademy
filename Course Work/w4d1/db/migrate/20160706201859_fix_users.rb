class FixUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      remove_column :users, :users
    end
  end
end

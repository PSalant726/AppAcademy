class CreateHouses < ActiveRecord::Migration
  def change
    create_table :houses do |t|
      t.string :address
    end
    add_index :houses, :address, unique: true
  end
end

class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :name
      t.integer :house_id
    end
    add_index :people, :house_id, unique: true
  end
end

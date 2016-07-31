class CreateBenches < ActiveRecord::Migration
  def change
    create_table :benches do |t|
      t.string :name, null: false
      t.text :description
      t.float :lat
      t.float :lng
      t.timestamps null: false
    end
    add_index :benches, :name, unique: true
  end
end

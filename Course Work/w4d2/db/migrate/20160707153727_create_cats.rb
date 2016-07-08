class CreateCats < ActiveRecord::Migration
  def change
    create_table :cats do |t|
      t.string :name, null: false
      t.date :birth_date, null: false
      t.string :color
      t.string :sex, limit: 1, null: false
      t.text :description
    end
  end
end

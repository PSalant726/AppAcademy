class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.string :title, null: false
      t.string :future_winner_id, null: false
      t.text :description
      t.boolean :public, null: false
      t.boolean :complete, null: false

      t.timestamps null: false
    end
    add_index :goals, :future_winner_id
  end
end

class CreateResponse < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.integer :user_id, null: false
      t.integer :ans_choice_id, null: false
      t.timestamps
    end
    add_index :responses, :user_id
    add_index :responses, :ans_choice_id
  end
end

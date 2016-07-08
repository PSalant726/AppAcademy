class AddBirthdayBack < ActiveRecord::Migration
  def change
    add_column :cats, :birth_date, :date
  end
end

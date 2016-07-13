class ChangeGoalsFutureWinnerIdColumnToInteger < ActiveRecord::Migration
  def change
    change_column :goals, :future_winner_id, 'integer USING CAST(future_winner_id AS integer)'
  end
end

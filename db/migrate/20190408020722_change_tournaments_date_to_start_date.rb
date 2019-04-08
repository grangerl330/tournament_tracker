class ChangeTournamentsDateToStartDate < ActiveRecord::Migration[5.2]
  def change
    rename_column :tournaments, :date, :start_date
  end
end

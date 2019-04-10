class AddWonToTournaments < ActiveRecord::Migration[5.2]
  def change
    add_column :tournaments, :won, :boolean
  end
end

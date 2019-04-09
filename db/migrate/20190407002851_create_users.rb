class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password_digest
      t.integer :match_wins, :default => 0
      t.integer :match_losses, :default => 0
      t.integer :tournaments_won, :default => 0
      t.integer :points, :default => 0

      t.timestamps
    end
  end
end

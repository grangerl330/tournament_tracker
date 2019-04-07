class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :password_digest
      t.integer :match_wins
      t.integer :match_losses
      t.integer :tournaments_won
      t.integer :points
      
      t.timestamps
    end
  end
end

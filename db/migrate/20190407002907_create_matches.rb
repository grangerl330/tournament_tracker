class CreateMatches < ActiveRecord::Migration[5.2]
  def change
    create_table :matches do |t|
      t.integer :round
      t.string :score
      t.boolean :won?
      t.integer :tournament_id

      t.timestamps
    end
  end
end

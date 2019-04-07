class CreateTournaments < ActiveRecord::Migration[5.2]
  def change
    create_table :tournaments do |t|
      t.string :title
      t.date :date
      t.string :location
      t.integer :draw_size
      t.integer :points
      t.integer :user_id
      
      t.timestamps
    end
  end
end

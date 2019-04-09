class CreateOpponentStyleTags < ActiveRecord::Migration[5.2]
  def change
    create_table :opponent_style_tags do |t|
      t.belongs_to :opponent, index: true, foreign_key: true
      t.belongs_to :style_tag, index: true, foreign_key: true
      
      t.timestamps
    end
  end
end

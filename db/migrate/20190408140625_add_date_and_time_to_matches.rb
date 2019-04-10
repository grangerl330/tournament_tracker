class AddDateAndTimeToMatches < ActiveRecord::Migration[5.2]
  def change
    add_column :matches, :date, :date
    add_column :matches, :time, :time
  end
end

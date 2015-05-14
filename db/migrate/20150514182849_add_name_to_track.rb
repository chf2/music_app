class AddNameToTrack < ActiveRecord::Migration
  def change
    add_column :tracks, :name, :string
    change_column :tracks, :name, :string, null: false
  end
end

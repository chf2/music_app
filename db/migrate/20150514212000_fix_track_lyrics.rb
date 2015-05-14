class FixTrackLyrics < ActiveRecord::Migration
  def change
    drop_table :tracks

    create_table :tracks do |t|
      t.integer :album_id, null: false
      t.string :track_type, null: false
      t.string :name, null: false
      t.text :lyrics

      t.timestamps null: false
    end
    add_index :tracks, :album_id
  end
end

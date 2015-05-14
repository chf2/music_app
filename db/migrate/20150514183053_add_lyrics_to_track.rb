class AddLyricsToTrack < ActiveRecord::Migration
  def change
    add_column :tracks, :text, :lyrics
  end
end

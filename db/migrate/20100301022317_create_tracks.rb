class CreateTracks < ActiveRecord::Migration
  def self.up
    create_table :tracks do |t|
      t.string :persistent_id
      t.string :name
      t.string :artist
      t.string :album
      t.integer :total_time
      t.integer :play_count
      t.timestamps
    end
    
    create_table :libraries_tracks, :id => false do |t|
      t.integer :library_id
      t.integer :track_id
    end
  end

  def self.down
    drop_table :libraries_tracks
    drop_table :tracks
  end
end

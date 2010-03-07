class CreateFavorites < ActiveRecord::Migration
  def self.up
    create_table :favorites do |t|
      t.integer :user_id
      t.string :artist_id
      t.string :album_id
      t.string :track_id
      t.timestamps
    end
  end

  def self.down
    drop_table :favorites
  end
end

# frozen_string_literal: true

class CreateSounds < ActiveRecord::Migration[6.0]
  def change
    create_table :sounds do |t|
      t.string :isrc, null: false
      t.string :thumbnail_url
      t.string :title, null: false
      t.string :artist, null: false
      t.string :spotify_url
      t.string :apple_music_url
      t.string :kkbox_url
      t.references :search, foreign_key: true
      t.timestamps
    end
    add_index :sounds, :created_at
  end
end

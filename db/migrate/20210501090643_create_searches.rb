class CreateSearches < ActiveRecord::Migration[6.0]
  def change
    create_table :searches do |t|
      t.string :keyword, null: false
      t.timestamps
    end
    add_index :searches, :keyword, unique: true
  end
end

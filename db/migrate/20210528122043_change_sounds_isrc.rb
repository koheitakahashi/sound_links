# frozen_string_literal: true

class ChangeSoundsIsrc < ActiveRecord::Migration[6.0]
  def change
    change_column_null :sounds, :isrc, true
  end
end

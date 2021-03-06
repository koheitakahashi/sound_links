# frozen_string_literal: true

class Sound < ApplicationRecord
  belongs_to :search

  validates :title, presence: true
  validates :artist, presence: true

  paginates_per 10

  def attributes_exclude(*attribute)
    exclude_keys = attribute.map(&:to_s)
    sound_attributes = attributes
    exclude_keys.each { |key| sound_attributes.delete(key) }
    sound_attributes
  end
end

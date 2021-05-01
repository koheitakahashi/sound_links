class Sound < ApplicationRecord
  belongs_to :search

  validates :isrc, presence: true
  validates :title, presence: true
  validates :artist, presence: true
end

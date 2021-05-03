# frozen_string_literal: true

class Search < ApplicationRecord
  has_many :sounds, dependent: :destroy

  validates :keyword, presence: true, uniqueness: true
end

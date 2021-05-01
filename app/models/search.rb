class Search < ApplicationRecord
  has_many :sounds

  validates :keyword, presence: true
end

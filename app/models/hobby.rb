class Hobby < ApplicationRecord
  belongs_to :portfolio

  validates :title, presence: true
  validates :percent, presence: true, numericality: { greather_than: 0, less_than_or_equal_to: 100 }
end

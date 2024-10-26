class Box < ApplicationRecord
  validates :room, presence: true
  validates :number, presence: true
  validates :description, presence: true
end

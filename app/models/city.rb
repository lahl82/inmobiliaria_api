class City < ApplicationRecord
  has_many :zones

  validates :name, uniqueness: true, presence: true, length: { in: 3..30 }, format: { with: /\A[A-Za-z\s]+\z/ }
end

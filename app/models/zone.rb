class Zone < ApplicationRecord
  belongs_to :city
  has_many :residences

  validates :name, uniqueness: true, presence: true, length: { in: 3..30 }
end

class Residence < ApplicationRecord
  belongs_to :zone

  validates :name, uniqueness: true, presence: true, length: { in: 3..30 }
end

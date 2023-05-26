class Property < ApplicationRecord
  belongs_to :agent

  enum type: { apartment: 0, shop: 1, house: 2, shed: 3, annex: 4 }
  enum state: { available: 0, suspended: 1, sold_in: 2, sold_out: 3 }
  enum mode: { sale: 0, rent: 1 }
end

class Visit < ApplicationRecord
  belongs_to :client
#   has_one :agent
  belongs_to :property

  validates :date, presence: true
  validates :date, format: { with: /\A\d{4}-\d{2}-\d{2}\z/, message: 'should be in the format YYYY-MM-DD' }
#   validates :date,
#             inclusion: { in: (Date.current..Date.current + 30.days), message: 'should be within the next 30 days' }
#   validates :date, date: { after: proc { Date.current }, message: 'should be a future date' }
end

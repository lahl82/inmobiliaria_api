class Visit < ApplicationRecord
  belongs_to :client
  #   has_one :agent
  belongs_to :property

  validates :date, presence: true
  validates :date, format: { with: /\A\d{4}-\d{2}-\d{2}\z/, message: 'should be in the format YYYY-MM-DD' }
  validates :date,
            inclusion: { in: (Date.current..Date.current + 30.days), message: 'should be within the next 30 days' }
  validate :date_should_be_future

  private

  def date_should_be_future
    return unless date.present? && date <= Date.current

    errors.add(:date, 'should be a future date')
  end
end

# typed: strict
# frozen_string_literal: true

class Request < ApplicationRecord
  belongs_to :user
  belongs_to :service

  validates :date, presence: true
  validate :date_should_be_future

  private

  def date_should_be_future
    return if date.present? && date > Time.zone.now && date < 30.days.from_now

    errors.add(:date, 'should be within the next 30 days')
  end
end

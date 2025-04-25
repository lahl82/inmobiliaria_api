# typed: strict
# frozen_string_literal: true

class Meeting < ApplicationRecord
  include AASM

  belongs_to :service
  has_many :requests

  validates :starting, presence: true
  validate :starting_should_be_future
  
  aasm no_direct_assignment: true, timestamps: true do
    state :active, initial: true
    state :suspended

    event :suspend do
      transitions from: :active, to: :suspended
    end

    event :resume do
      transitions from: :suspended, to: :active
    end
  end

  private

  def starting_should_be_future
    return if starting.present? && starting > Time.zone.now && starting < 30.days.from_now
    errors.add(:starting, 'should be within the next 30 days')
  end
end

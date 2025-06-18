# typed: strict
# frozen_string_literal: true

class AppointmentSlot < ApplicationRecord
  include AASM

  belongs_to :company
  
  has_many :appointments
  has_many :appointment_slot_services
  has_many :services, through: :appointment_slot_services

  validates :starting, :duration, :max_requests, presence: true
  validate :starting_should_be_future

  aasm column: :state, no_direct_assignment: true, timestamps: true do
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

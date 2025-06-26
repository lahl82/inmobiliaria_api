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
    return if starting.blank?

    now = Time.zone.now
    if starting <= now
      errors.add(:starting, :not_in_future)
    elsif starting > now + 30.days
      errors.add(:starting, :too_far_in_future)
    end
  end
end

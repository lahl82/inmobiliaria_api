# typed: strict
# frozen_string_literal: true

class Appointment < ApplicationRecord
  include AASM

  belongs_to :customer, class_name: "User", foreign_key: "user_id"
  belongs_to :appointment_slot

  has_many :ratings
  has_many :notifications

  aasm column: :state, no_direct_assignment: true, timestamps: true do
    state :active, initial: true
    state :arrived
    state :attended
    state :with_pending_info
    state :finished
    state :missed
    state :user_canceled
    state :seller_canceled
  
    event :mark_arrived do
      transitions from: :active, to: :arrived
    end
  
    event :attend do
      transitions from: [:active, :arrived], to: :attended
    end
  
    event :add_pending_info do
      transitions from: :attended, to: :with_pending_info
    end
  
    event :finish do
      transitions from: [:attended, :with_pending_info], to: :finished
    end
  
    event :mark_as_missed do
      transitions from: :active, to: :missed
    end
  
    event :cancel_by_user do
      transitions from: :active, to: :user_canceled
    end
  
    event :cancel_by_seller do
      transitions from: :active, to: :seller_canceled
    end
  end
end

class Notification < ApplicationRecord
    include AASM
  
    belongs_to :appointment
  
    validates :description, presence: true
    validates :sent_at, presence: true
  
    aasm column: :state, no_direct_assignment: true, timestamps: true do
      state :pending, initial: true
      state :sent
      state :failed
  
      event :mark_as_sent do
        transitions from: :pending, to: :sent
      end
  
      event :mark_as_failed do
        transitions from: [:pending, :sent], to: :failed
      end
    end
  end
  
# typed: strict
# frozen_string_literal: true

class Rating < ApplicationRecord
  include AASM

  belongs_to :user
  belongs_to :appointment

  validates :description, presence: true
  validates :score, presence: true, numericality: { only_integer: true, greater_than: 0, less_than: 6 }

  aasm column: :state, no_direct_assignment: true, timestamps: true do
    state :visible, initial: true
    state :hidden

    event :hide do
      transitions from: :visible, to: :hidden
    end

    event :show do
      transitions from: :hidden, to: :visible
    end
  end
end

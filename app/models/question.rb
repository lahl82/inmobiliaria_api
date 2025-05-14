# typed: strict
# frozen_string_literal: true

class Question < ApplicationRecord
  include AASM

  belongs_to :user
  belongs_to :service

  validates :description, presence: true

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

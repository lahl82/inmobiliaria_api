# typed: strict
# frozen_string_literal: true

class ServiceType < ApplicationRecord
  include AASM

  has_many :services

  validates :name, uniqueness: true, presence: true, length: { in: 3..100 }, format: { with: /\A[\p{L}\s]+\z/, message: 'solo permite letras y espacios' }

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
end

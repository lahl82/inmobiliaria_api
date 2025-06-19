class Company < ApplicationRecord
    include AASM

    has_many :users
    has_many :appointment_slots
    has_many :services

    aasm column: :state, no_direct_assignment: true, timestamps: true do
        state :created, initial: true
        state :active
        state :suspended
        state :archived

        event :activate do
            transitions from: [:created, :suspended], to: :active
        end

        event :suspend do
            transitions from: :active, to: :suspended
        end

        event :archive do
            transitions from: [:created, :active, :suspended], to: :archived
        end

        event :resume do
            transitions from: :suspended, to: :active
        end
    end
end

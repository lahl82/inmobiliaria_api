# typed: strict
# frozen_string_literal: true

class Service < ApplicationRecord
  include AASM
  include ActiveStorageSupport::SupportForBase64

  belongs_to :user
  belongs_to :service_type

  has_many :requests, dependent: :destroy
  has_many :questions, dependent: :destroy
  has_many :ratings, dependent: :destroy

  has_many_base64_attached :photos

  validates :title, presence: true, length: { maximum: 255 }
  validates :description, presence: true, length: { maximum: 1000 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  aasm no_direct_assignment: true, timestamps: true do
    state :created, initial: true
    state :rejected, :active, :disabled, :suspended

    event :reject do
      transitions from: :created, to: :rejected
    end

    event :activate do
      transitions from: :created, to: :active
    end

    event :deactivate do
      transitions from: :active, to: :disabled
    end

    event :reactivate do
      transitions from: :disabled, to: :active
    end

    event :suspend do
      transitions from: :active, to: :suspended
    end

    event :resume do
      transitions from: :suspended, to: :active
    end
  end
end

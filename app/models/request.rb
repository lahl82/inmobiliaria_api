# typed: strict
# frozen_string_literal: true

class Request < ApplicationRecord
  include AASM

  belongs_to :user
  belongs_to :meeting

  has_many :ratings
  has_many :notifications

  aasm no_direct_assignment: true, timestamps: true do
    state :active, initial: true
    state :user_canceled
    state :seller_canceled
    state :missed
  
    event :cancel_by_user do
      transitions from: :active, to: :user_canceled
    end
  
    event :cancel_by_seller do
      transitions from: :active, to: :seller_canceled
    end
  
    event :mark_as_missed do
      transitions from: :active, to: :missed
    end
  end

end

# typed: strict
# frozen_string_literal: true

class Question < ApplicationRecord
  belongs_to :user
  belongs_to :service

  validates :description, presence: true
end

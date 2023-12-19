# typed: strict
# frozen_string_literal: true

class ServiceType < ApplicationRecord
  has_many :services

  validates :name, uniqueness: true, presence: true, length: { in: 3..100 }, format: { with: /\A[A-Za-z\s]+\z/ }
end

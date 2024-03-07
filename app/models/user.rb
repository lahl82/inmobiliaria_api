# typed: strict
# frozen_string_literal: true

class User < ApplicationRecord
  include AASM
  include Devise::JWT::RevocationStrategies::JTIMatcher
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  has_many :requests
  has_many :services
  has_many :questions
  has_many :ratings

  enum :role, %i[admin seller buyer], validate: true

  NAME_REGEX = /\A([[[:alpha:]]-' ])*\z/
  PHONE_REGEX = /\A(((\(\d+\))|(\+))?([\d\-[[:space:]]]))+\z/

  validates :name, :last_name, :phone, presence: true
  validates :name, format: { with: NAME_REGEX }, length: { minimum: 2, maximum: 50 }
  validates :last_name, format: { with: NAME_REGEX }, length: { minimum: 2, maximum: 50 }
  validates :phone, format: { with: PHONE_REGEX }, length: { minimum: 11, maximum: 20 }
  validates :role, presence: true

  aasm no_direct_assignment: true, timestamps: true do
    state :created, initial: true
    state :active, :suspended

    event :activate do
      transitions from: :created, to: :active
    end

    event :suspend do
      transitions from: :active, to: :suspended
    end

    event :resume do
      transitions from: :suspended, to: :active
    end
  end

  # def jwt_payload
  #   super.merge('foo' => 'bar')
  # end
end

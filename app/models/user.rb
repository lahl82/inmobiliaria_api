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

  has_many :customer_requests, class_name: "Request", foreign_key: "user_id"
  has_many :seller_services, class_name: "Service", foreign_key: "user_id"
  has_many :appointment_slots
  has_many :questions
  has_many :ratings

  ROLES = %i[admin seller customer]

  NAME_REGEX = /\A([[[:alpha:]]-' ])*\z/
  PHONE_REGEX = /\A(((\(\d+\))|(\+))?([\d\-[[:space:]]]))+\z/

  validates :name, :last_name, :phone, presence: true
  validates :name, format: { with: NAME_REGEX }, length: { minimum: 2, maximum: 50 }
  validates :last_name, format: { with: NAME_REGEX }, length: { minimum: 2, maximum: 50 }
  validates :phone, format: { with: PHONE_REGEX }, length: { minimum: 11, maximum: 20 }

  after_initialize :assign_default_role, if: :new_record?

  aasm column: :state, no_direct_assignment: true, timestamps: true do
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

  # Scope: User.with_role(:seller)
  scope :with_role, ->(role) {
    where("role_mask & ? != 0", 2**ROLES.index(role))
  }

  def assign_default_role
    add_role(:customer)
  end

  # Setter: user.roles = [:seller, :customer]
  def roles=(roles)
    self.role_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.sum
  end

  # Getter: user.roles => [:seller, :customer]
  def roles
    ROLES.reject do |r|
      ((role_mask || 0) & 2**ROLES.index(r)).zero?
    end
  end

  # Check single role: user.has_role?(:seller)
  def has_role?(role)
    roles.include?(role)
  end

  # Add a role: user.add_role(:seller)
  def add_role(role)
    return if has_role?(role)
    self.role_mask = (role_mask || 0) + 2**ROLES.index(role)
  end

  # Remove a role: user.remove_role(:customer)
  def remove_role(role)
    return unless has_role?(role)
    self.role_mask = role_mask - 2**ROLES.index(role)
  end

  # def jwt_payload
  #   super.merge('foo' => 'bar')
  # end
end

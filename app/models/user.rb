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

  belongs_to :company, optional: true

  has_many :appointments
  has_many :questions
  has_many :ratings

  ROLES = %i[root support seller assistant customer]

  NAME_REGEX = /\A([[[:alpha:]]-' ])*\z/
  PHONE_REGEX = /\A(((\(\d+\))|(\+))?([\d\-[[:space:]]]))+\z/

  validates :name, :last_name, :phone, presence: true
  validates :name, format: { with: NAME_REGEX }, length: { minimum: 2, maximum: 50 }
  validates :last_name, format: { with: NAME_REGEX }, length: { minimum: 2, maximum: 50 }
  validates :phone, format: { with: PHONE_REGEX }, length: { minimum: 11, maximum: 20 }
  validates :company, presence: true, if: -> { has_any_role?(:seller, :assistant) }

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

  # Scope que permite buscar usuarios con un rol específico
  # Ejemplo: User.with_role(:seller)
  scope :with_role, ->(role) {
    where("role_mask & ? != 0", 2**ROLES.index(role))
  }

  # Asigna el rol :customer por defecto al crear un nuevo usuario
  # Se ejecuta automáticamente en new_record?
  def assign_default_role
    add_role(:customer)
  end

  # Setter para asignar múltiples roles a un usuario
  # Ejemplo: user.roles = [:seller, :support]
  def roles=(roles)
    self.role_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.sum
  end

  # Getter que devuelve un arreglo de roles activos para el usuario
  # Ejemplo: user.roles => [:seller, :support]
  def roles
    ROLES.reject do |r|
      ((role_mask || 0) & 2**ROLES.index(r)).zero?
    end
  end

  # Genera métodos dinámicos como seller?, support?, customer?, etc.
  # Ejemplo: user.seller? => true/false
  ROLES.each do |role|
    define_method("#{role}?") { has_role?(role) }
  end

  # Verifica si el usuario tiene un rol específico
  # Ejemplo: user.has_role?(:seller) => true/false
  def has_role?(role)
    roles.include?(role)
  end

  # Verifica si el usuario tiene al menos uno de varios roles
  # Ejemplo: user.has_any_role?(:seller, :support) => true/false
  def has_any_role?(*roles)
    roles.any? { |r| has_role?(r) }
  end

  # Agrega un rol al usuario si aún no lo tiene
  # Ejemplo: user.add_role(:support)
  def add_role(role)
    return if has_role?(role)
    self.role_mask = (role_mask || 0) + 2**ROLES.index(role)
  end

  # Elimina un rol del usuario si lo tiene
  # Ejemplo: user.remove_role(:customer)
  def remove_role(role)
    return unless has_role?(role)
    self.role_mask = role_mask - 2**ROLES.index(role)
  end

  # def jwt_payload
  #   super.merge('foo' => 'bar')
  # end
end

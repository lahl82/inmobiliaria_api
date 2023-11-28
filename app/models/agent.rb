class Agent < ApplicationRecord
  belongs_to :user
  has_many :properties

  NAME_REGEX = /\A([[[:alpha:]]-' ])*\z/
  PHONE_REGEX = /\A(((\(\d+\))|(\+))?([\d\-[[:space:]]]))+\z/

  validates_presence_of :name, :last_name, :phone, :agency
  validate :unique_name_and_last_name
  validates :name, format: { with: NAME_REGEX }, length: { minimum: 2, maximum: 50 }
  validates :last_name, format: { with: NAME_REGEX }, length: { minimum: 2, maximum: 50 }
  validates :phone, format: { with: PHONE_REGEX }, length: { minimum: 11, maximum: 20 }

  def unique_name_and_last_name
    return unless Agent.where(name:, last_name:).exists?

    errors.add(:base, 'Name and last name combination must be unique')
  end
end

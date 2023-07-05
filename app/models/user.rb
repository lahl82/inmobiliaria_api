class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  enum role: { admin: 0, agent: 1, client: 2 }

  validates_presence_of :email, :password, :role
  validates :email, uniqueness: true
  validates_format_of :email, with: URI::MailTo::EMAIL_REGEXP
  validates :role, inclusion: { within: %w[client agent admin] }
  validates :password, length: { maximum: 72, minimum: 8 }, confirmation: true

  # def jwt_payload
  #   super.merge('foo' => 'bar')
  # end
end

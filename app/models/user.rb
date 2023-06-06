class User < ApplicationRecord
  enum role: { admin: 0, agent: 1, client: 2 }

  validates_presence_of :email, :password, :role
  validates_uniqueness_of :email
  validates_format_of :email, with: URI::MailTo::EMAIL_REGEXP
  validates :role, inclusion: { within: %w[client agent admin] }
  validates :password, length: { maximum: 72, minimum: 8 }, confirmation: true
end

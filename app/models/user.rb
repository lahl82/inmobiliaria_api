class User < ApplicationRecord
  enum role: { admin: 0, agent: 1, customer: 2 }

  validates :email, presence: true
  validates :password, presence: true
end

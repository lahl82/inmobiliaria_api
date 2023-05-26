class User < ApplicationRecord
  enum role: { admin: 0, agent: 1, customer: 2 }
end

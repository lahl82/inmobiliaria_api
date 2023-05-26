class Visit < ApplicationRecord
    belongs_to :customer
    has_one :agent
    has_one :property
end

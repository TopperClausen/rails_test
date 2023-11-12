class BasketProduct < ApplicationRecord
    belongs_to :user
    belongs_to :product

    scope :not_empty, -> { where.not(amount: 0) }
end

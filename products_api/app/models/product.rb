class Product < ApplicationRecord
    validates :name, presence: true
    validates :price, presence: true

    has_many :basket_product, class_name: :BasketProduct, foreign_key: :product_id
    has_many :users, through: :basket_product, class_name: :User, source: :user
end

class Product < ApplicationRecord
    validates :name, presence: true
    validates :price, presence: true

    has_many :basket_product, class_name: :BasketProduct, foreign_key: :product_id
    has_many :users, through: :basket_product, class_name: :User, source: :user

    def to_ordered_product!(order_id:)
        OrderedProduct.create!(order_id: order_id, product_id: self.id, baught_price: self.price)
    end
end

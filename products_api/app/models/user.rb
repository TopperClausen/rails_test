class User < ApplicationRecord
    has_secure_password

    validates :email, presence: true, :uniqueness => { :case_sensitive => false }
    validates :password, length: { minimum: 6 }
    validates :full_name, presence: true

    has_many :orders, class_name: :Order, foreign_key: :user_id
    has_many :basket_product, class_name: :BasketProduct, foreign_key: :user_id
    has_many :basket, class_name: :Product, through: :basket_product, source: :product

    def jwt
        payload = {
            id: self.id,
            email: self.email
        }
        JwtService.encode(payload, 1.week.from_now)
    end

    def self.from_jwt(jwt)
        payload = JwtService.decode(jwt)
        User.find(payload[:id])
    end
end

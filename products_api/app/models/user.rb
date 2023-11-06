class User < ApplicationRecord
    has_secure_password

    validates :email, presence: true, :uniqueness => { :case_sensitive => false }
    validates :password, length: { minimum: 6 }
    validates :full_name, presence: true

    def jwt
        payload = {
            id: self.id,
            email: self.email
        }
        JwtService.encode(payload, 1.week.from_now)
    end

    def self.from_jwt(jwt)
        payload = JwtService.decode(jwt)
        User.find(email: payload[:email])
    end
end

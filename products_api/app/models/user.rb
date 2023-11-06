class User < ApplicationRecord
    has_secure_password

    validates :email, format: {with: URI::MailTo::EMAIL_REGEXP}, presence: true, :uniqueness => { :case_sensitive => false }
    validates :password, length: { minimum: 6 }
    validates :full_name, presence: true
end

class Apikey < ApplicationRecord
    before_validation :set_key, on: :create

    validates :key, presence: true

    def set_key
        self.key = Digest::UUID.uuid_v4 if key.blank?
    end
end

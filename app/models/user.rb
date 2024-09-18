class User < ApplicationRecord
    normalizes :email, with: -> email { email.downcase }
    validates :email, presence: true, length: { maximum: 150 },
              format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i },
              uniqueness: { case_sensitive: false }

    validates :name, presence: true, length: { maximum: 50 }

    has_secure_password
    validates :password, length: { minimum: 6 }
end

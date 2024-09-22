# frozen_string_literal: true

class User < ApplicationRecord
  attr_accessor :remember_token

  normalizes :email, with: ->(email) { email.downcase }
  validates :email, presence: true, length: { maximum: 150 },
                    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i },
                    uniqueness: { case_sensitive: false }

  validates :name, presence: true, length: { maximum: 50 }

  has_secure_password
  validates :password, length: { minimum: 6 }, allow_nil: true

  # Return digest for string
  def self.digest(string)
    cost = if ActiveModel::SecurePassword.min_cost
             BCrypt::Engine::MIN_COST
           else
             BCrypt::Engine.cost
           end
    BCrypt::Password.create(string, cost:)
  end

  # Return random token
  def self.new_token
    SecureRandom.urlsafe_base64
  end

  # Remember user record token to db
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Return true if token consistent digest
  def authenticated?(remember_token)
    return false if remember_digest.nil?

    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # Forget user
  def forget
    update_attribute(:remember_digest, nil)
  end
end

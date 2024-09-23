# frozen_string_literal: true

class User < ApplicationRecord
  attr_accessor :remember_token, :activation_token, :reset_token

  before_create :create_activation_digest
  before_save :downcase_email
  validates :email, presence: true, length: { maximum: 150 },
                    format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i },
                    uniqueness: { case_sensitive: false }

  validates :name, presence: true, length: { maximum: 50 }

  has_secure_password
  validates :password, length: { minimum: 6 }, allow_nil: true

  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest, User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

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
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?

    BCrypt::Password.new(digest).is_password?(token)
  end

  # Forget user
  def forget
    update_attribute(:remember_digest, nil)
  end

  def activate
    update_attribute(:activated, true)
    update_attribute(:activated_at, Time.zone.now)
  end

  def send_activation_email
    UserMailer.account_activation(@user).deliver_now
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  private

  def downcase_email
    self.email = email.downcase
  end

  # Create token and digest activation
  def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
  end
end

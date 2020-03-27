class User < ApplicationRecord
  has_secure_password
  validates :full_name, :username, :password_digest, :email,presence: true
  validates :username, uniqueness: true
  validates :email, format:{with: URI::MailTo::EMAIL_REGEXP}, uniqueness: true

  has_many :stuffs
end
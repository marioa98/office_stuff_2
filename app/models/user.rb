class User < ApplicationRecord
  has_secure_password

  validates :full_name, :username, :email, presence: true
  validates :password, :password_digest,  presence: {on: :create}
  validates :username, uniqueness: true
  validates :email, format:{with: URI::MailTo::EMAIL_REGEXP}, uniqueness: true

  has_many :stuffs
end
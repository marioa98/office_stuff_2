class User < ApplicationRecord
    has_secure_password
    validates :full_name, :username, :password_digest, presence: true
    validates :username, uniqueness: true
    has_many :stuffs
end
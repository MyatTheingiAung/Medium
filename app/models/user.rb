class User < ApplicationRecord
    has_secure_password 
    has_many :posts
    has_many :comments
    validates :name, presence: true
    validates :email, presence: true, uniqueness: true
    validates :password, presence: true
    validates :password_confirmation, presence: true
    validates :password, confirmation: { case_sensitive: true }
    validates :bio, presence: true
end

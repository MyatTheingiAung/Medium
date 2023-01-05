class User < ApplicationRecord
    has_secure_password 
    has_many :posts
    has_many :comments
    has_one_attached :image
    validates :image, presence: false
    validates :name, presence: true
    validates :email, presence: true, uniqueness: true
    validates :password, presence: true, on: :create
    validates :password_confirmation, presence: true ,on: :create
    validates :password, confirmation: { case_sensitive: true }
    validates :bio, presence: true
end

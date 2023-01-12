class User < ApplicationRecord
    include ImageUploader::Attachment(:image)
    has_secure_password 
    has_many :posts
    has_many :comments
    validates :name, presence: true,length: { minimum: 2 }
    validates :email, presence: true, uniqueness: true, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/ }
    validates :password, presence: true, on: :create
    validates :password_confirmation, presence: true, on: :create
    validates :password, confirmation: { case_sensitive: true }
    validates :bio, presence: true
end

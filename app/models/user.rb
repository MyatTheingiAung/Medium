class User < ApplicationRecord
    include ImageUploader::Attachment(:image)
    has_secure_password 
    has_many :posts
    has_many :comments
    validates :name, presence: true,length: { minimum: 2 }
    validates :email, presence: true, uniqueness: true, :format => { :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/ }
    validates :password_confirmation, confirmation: true
    with_options on: :update_password  do
        validates :password, presence: true
        validates :password_confirmation, presence: true
    end
    validates :bio, presence: true

    
end

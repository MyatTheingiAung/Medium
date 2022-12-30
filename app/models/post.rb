class Post < ApplicationRecord
    belongs_to :user
    has_many :comments
    belongs_to :category
    has_one_attached :image
    validates :title, presence: true
    validates :user_id, presence: true
    validates :category_id, presence: true
    validates :image, presence: true
    validates :description, presence: true
    validate :correct_image_type

    private
    def correct_image_type
        if image.attached? && !image.content_type.in?(%w(image/jpeg image/png image/gif))
            errors.add(:image, "must be a jpeg,png or gif")
        end
    end
end

class Post < ApplicationRecord
    belongs_to :user, optional: true
    has_many :comments, dependent: :destroy
    belongs_to :category, optional: true
    has_one_attached :image, dependent: :destroy
    validates :title, presence: true, length: { maximum: 100 }
    validates :user_id, presence: true
    validates :category_id, presence: true
    validates :image, presence: true
    validates :description, presence: true ,length: { minimum: 20 }
    validate :correct_image_type

    private
    def correct_image_type
        if image.attached? && !image.content_type.in?(%w(image/jpeg image/png image/gif))
            errors.add(:image, "must be a jpeg,png or gif")
        end
    end
end

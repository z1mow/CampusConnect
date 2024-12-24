class User < ApplicationRecord
  has_secure_password

  # İlişkiler
  has_many :messages, dependent: :destroy
  has_one_attached :profile_picture

  # Validasyonlar
  validates :name, presence: true
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validate :profile_picture_content_type

  private
  class User < ApplicationRecord
    has_one_attached :profile_picture
  
    # Diğer ilişkiler ve doğrulamalar burada olabilir
  end
  has_one_attached :profile_picture
  def profile_picture_content_type
    if profile_picture.attached? && !profile_picture.content_type.in?(%w[image/png image/jpg image/jpeg])
      errors.add(:profile_picture, 'must be a PNG, JPG, or JPEG')
    end
  end
end
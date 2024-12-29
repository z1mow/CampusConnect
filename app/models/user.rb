class User < ApplicationRecord
    has_secure_password
    has_many :messages

    has_one :profile, dependent: :destroy
    has_many :photos, dependent: :destroy
    has_many :group_members, dependent: :destroy
    has_many :community_groups, through: :group_members
    has_one_attached :profile_picture
  
    validates :name, presence: true, length: { maximum: 50 }
    validates :username, presence: true, 
                        uniqueness: { case_sensitive: false },
                        length: { minimum: 3, maximum: 12 },
                        format: { with: /\A[a-zA-Z0-9_]+\z/,
                                 message: "sadece harf, rakam ve alt çizgi (_) içerebilir" }
    validates :email, presence: true, uniqueness: true
    validate :email_domain_validation
    validate :profile_picture_content_type

    def member_of?(group)
      community_groups.include?(group)
    end

    def full_name
      name || username
    end

    private

    def profile_picture_content_type
      if profile_picture.attached? && !profile_picture.content_type.in?(%w[image/png image/jpg image/jpeg])
        errors.add(:profile_picture, 'must be a PNG, JPG, or JPEG')
      end
    end

    def email_domain_validation
      allowed_domains = ['@live.acibadem.edu.tr', '@acibadem.edu.tr']
      unless allowed_domains.any? { |domain| email.end_with?(domain) }
        errors.add(:email, 'must be from an allowed domain (e.g., @live.acibadem.edu.tr, @acibadem.edu.tr)')
      end
    end
end

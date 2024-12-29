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

  # Sabitler (Departments ve Titles için)
  DEPARTMENTS = %w[Computer_Science BME Medical Nursing MBG]
  TITLES = %w[Student Lecturer]
  STUDENT_CLASS = %w[Prep 1 2 3 4 5 6]

  # Doğrulamalar
  validates :name, presence: true, length: { maximum: 50 }
  validates :username, presence: true, uniqueness: true, length: { maximum: 50 }
  validates :email, presence: true, uniqueness: true
  validates :department, inclusion: { in: DEPARTMENTS, message: "%{value} is not a valid department" }, allow_blank: true
  validates :title, inclusion: { in: TITLES, message: "%{value} is not a valid title" }, allow_blank: true
  validates :student_class,inclusion: { in: STUDENT_CLASS, message: "%{value} is not a valid class" }, allow_blank: true
  validate :email_domain_validation
  validate :profile_picture_content_type

  # Yeni kullanıcı oluşturulduğunda varsayılan değerler
  after_initialize :set_default_department_and_title, if: :new_record?

  # Kullanıcı belirli bir grubun üyesi mi kontrolü
  def member_of?(group)
    community_groups.include?(group)
  end

  private

  # Profil fotoğrafı türü kontrolü
  def profile_picture_content_type
    if profile_picture.attached? && !profile_picture.content_type.in?(%w[image/png image/jpg image/jpeg])
      errors.add(:profile_picture, 'must be a PNG, JPG, or JPEG')
    end
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
  # E-posta alan adı kontrolü
  def email_domain_validation
    allowed_domains = ['@live.acibadem.edu.tr', '@acibadem.edu.tr']
    unless allowed_domains.any? { |domain| email.end_with?(domain) }
      errors.add(:email, 'must be from an allowed domain (e.g., @live.acibadem.edu.tr, @acibadem.edu.tr)')
    end
  end

  before_validation :set_default_department_and_title, on: :create

  def set_default_department_and_title
    self.department ||= "Computer_Science"
    self.title ||= "Student"
  end
end
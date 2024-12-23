class User < ApplicationRecord
  has_secure_password
  has_many :messages

  validates :name, presence: true
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
  validate :email_domain_validation

  private

  def email_domain_validation
    allowed_domains = ['@live.acibadem.edu.tr', '@acibadem.edu.tr']
    unless allowed_domains.any? { |domain| email.end_with?(domain) }
      errors.add(:email, 'must be from an allowed domain (e.g., @live.acibadem.edu.tr, @acibadem.edu.tr)')
    end
  end
end
class User < ApplicationRecord
    has_secure_password
    has_many:messages, dependent: :destroy
    validates :name, presence: true
    validates :username, presence: true, uniqueness: true
    validates :email, presence: true, uniqueness: true
  end
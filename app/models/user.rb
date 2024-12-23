class User < ApplicationRecord
    has_secure_password
    has_many :messages

    has_one :profile, dependent: :destroy
    has_many :photos, dependent: :destroy
    has_many :group_members, dependent: :destroy
    has_many :community_groups, through: :group_members
  
    validates :name, presence: true, length: { maximum: 50 }
    validates :username, presence: true, uniqueness: true, length: { maximum: 50 }
    validates :email, presence: true, uniqueness: true
  end
class Friend < ApplicationRecord
  belongs_to :user, class_name: 'User'
  belongs_to :friend, class_name: 'User'
  
  validates :user_id, presence: true
  validates :friend_id, presence: true
  validates :status, presence: true, inclusion: { in: ['pending', 'accepted', 'rejected'] }
  validate :not_self_referential
  validates :user_id, uniqueness: { scope: :friend_id }

  private

  def not_self_referential
    if user_id == friend_id
      errors.add(:friend_id, "can't be the same as user")
    end
  end
end

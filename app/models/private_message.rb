class PrivateMessage < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'

  validates :content, presence: true
  validate :users_are_friends

  scope :between_users, ->(user1, user2) do
    where(sender: [user1, user2], receiver: [user1, user2])
      .order(created_at: :asc)
  end

  private

  def users_are_friends
    unless sender.friends_with?(receiver)
      errors.add(:base, "Sadece arkadaşlar arasında mesajlaşma yapılabilir")
    end
  end
end

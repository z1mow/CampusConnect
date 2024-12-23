class CommunityGroup < ApplicationRecord
    belongs_to :creator, class_name: "User"
    validates :name, presence: true

    def created_by?(user)
        creator == user
      end
  
    # Many-to-many relationship with User through GroupMember
    has_many :group_members, dependent: :destroy
    has_many :users, through: :group_members
  
    has_many :messages, dependent: :destroy
  end
  

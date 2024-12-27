class CommunityGroup < ApplicationRecord
    belongs_to :creator, class_name: "User"
    validates :name, presence: true, uniqueness: true
    validates :description, presence: true
    validates :category, presence: true, inclusion: { 
      in: %w[study club project department other],
      message: "%{value} geçerli bir kategori değil" 
    }

    # Many-to-many relationship with User through GroupMember
    has_many :group_members, dependent: :destroy
    has_many :users, through: :group_members
  
    has_many :messages, dependent: :destroy

    after_create :add_creator_as_member

    private

    def add_creator_as_member
        users << creator unless users.include?(creator)
    end
end
  

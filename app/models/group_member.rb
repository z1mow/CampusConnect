class GroupMember < ApplicationRecord
    belongs_to :user
    belongs_to :community_group

    validates :user_id, uniqueness: { scope: :community_group_id }
end
  
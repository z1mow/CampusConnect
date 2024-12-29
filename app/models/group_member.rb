class GroupMember < ApplicationRecord
    belongs_to :user
    belongs_to :community_group

    validates :user_id, uniqueness: { scope: :community_group_id }

    attribute :last_seen_at, :datetime, default: -> { Time.now }
end
  
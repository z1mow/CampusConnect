class Message < ApplicationRecord
    belongs_to :user
    belongs_to :community_group
    validates :body, presence: true
end

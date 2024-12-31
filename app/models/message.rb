class Message < ApplicationRecord
    belongs_to :user
    belongs_to :community_group
  
    validates :body, presence: true
  
    after_commit :refresh_message_summary
  
    private
  
    def refresh_message_summary
      ActiveRecord::Base.connection.execute('REFRESH MATERIALIZED VIEW group_message_summary;')
    end
end
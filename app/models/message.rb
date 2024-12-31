class Message < ApplicationRecord
    belongs_to :user
    belongs_to :community_group
  
    validates :body, presence: true
    validates :user_id, presence: true
    validates :community_group_id, presence: true
  
    after_commit :refresh_group_message_summary
  
    private
  
    def refresh_group_message_summary
      ActiveRecord::Base.connection.execute('REFRESH MATERIALIZED VIEW CONCURRENTLY group_message_summary;')
    rescue ActiveRecord::StatementInvalid => e
      # If concurrent refresh fails (first time), do a regular refresh
      if e.message.include?('cannot refresh materialized view "group_message_summary" concurrently')
        ActiveRecord::Base.connection.execute('REFRESH MATERIALIZED VIEW group_message_summary;')
      else
        raise e
      end
    end
end
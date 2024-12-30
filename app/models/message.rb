class Message < ApplicationRecord
    belongs_to :user
    belongs_to :community_group
  
    after_commit :refresh_message_summary
  
    private
  
    def refresh_message_summary
      # Transaction ve izolasyon seviyesi ekleniyor
      ActiveRecord::Base.transaction(isolation: :read_committed) do
        ActiveRecord::Base.connection.execute('REFRESH MATERIALIZED VIEW group_message_summary;')
      end
    rescue ActiveRecord::ActiveRecordError => e
      Rails.logger.error("Hata: group_message_summary materialized view güncellenemedi. Detay: #{e.message}")
      raise ActiveRecord::Rollback
    end
  end
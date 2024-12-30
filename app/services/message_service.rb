class MessageService
  def self.send_message(sender:, group:, content:)
    ActiveRecord::Base.transaction do
      # PostgreSQL'de Read Committed isolation seviyesini ayarla
      ActiveRecord::Base.connection.execute('SET TRANSACTION ISOLATION LEVEL READ COMMITTED')
      
      # Gönderenin grup üyesi olup olmadığını kontrol et
      unless group.users.include?(sender)
        raise ActiveRecord::RecordInvalid, "Sender is not a member of this group"
      end
      
      # Mesajı oluştur
      message = Message.create!(
        sender: sender,
        group: group,
        content: content,
        sent_at: Time.current
      )
      
      # Grup son mesaj zamanını güncelle
      group.update!(last_message_at: Time.current)
      
      # Materyalize view'u yenile
      refresh_message_summary(group.id)
      
      message
    end
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error "Message sending failed: #{e.message}"
    raise e
  end
  
  private
  
  def self.refresh_message_summary(group_id)
    ActiveRecord::Base.connection.execute(
      "REFRESH MATERIALIZED VIEW CONCURRENTLY group_message_summary WHERE group_id = #{group_id}"
    )
  end
end 
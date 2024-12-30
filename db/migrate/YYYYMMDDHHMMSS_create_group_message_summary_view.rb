class CreateGroupMessageSummaryView < ActiveRecord::Migration[7.0]
  def up
    execute <<-SQL
      CREATE MATERIALIZED VIEW group_message_summary AS
      SELECT 
        groups.id as group_id,
        COUNT(messages.id) as message_count,
        MAX(messages.sent_at) as last_message_at,
        array_agg(DISTINCT messages.sender_id) as unique_senders
      FROM groups
      LEFT JOIN messages ON messages.group_id = groups.id
      GROUP BY groups.id;
      
      CREATE UNIQUE INDEX ON group_message_summary (group_id);
    SQL
  end

  def down
    execute "DROP MATERIALIZED VIEW IF EXISTS group_message_summary;"
  end
end 
class CreateGroupMessageSummaryView < ActiveRecord::Migration[7.0]
  def up
    execute "DROP MATERIALIZED VIEW IF EXISTS group_message_summary;"
    
    execute <<-SQL
      CREATE MATERIALIZED VIEW group_message_summary AS
      SELECT 
        community_groups.id as community_group_id,
        COUNT(messages.id) as message_count,
        MAX(messages.created_at) as last_message_at
      FROM community_groups
      LEFT JOIN messages ON messages.community_group_id = community_groups.id
      GROUP BY community_groups.id;

      CREATE UNIQUE INDEX ON group_message_summary (community_group_id);
    SQL
  end

  def down
    execute "DROP MATERIALIZED VIEW IF EXISTS group_message_summary;"
  end
end 
class AddAndPopulateMessageCountToCommunityGroups < ActiveRecord::Migration[7.2]
  def up
    # Add message_count column if it doesn't exist
    unless column_exists?(:community_groups, :message_count)
      add_column :community_groups, :message_count, :integer, default: 0
    end

    # Create the group_message_summary materialized view
    execute <<-SQL
      CREATE MATERIALIZED VIEW IF NOT EXISTS group_message_summary AS
      SELECT 
        community_group_id,
        COUNT(*) as message_count,
        MAX(created_at) as last_message_at
      FROM messages
      GROUP BY community_group_id
      WITH DATA;
    SQL

    # Create a unique index to support concurrent refresh
    execute <<-SQL
      CREATE UNIQUE INDEX IF NOT EXISTS idx_group_message_summary_unique 
      ON group_message_summary(community_group_id);
    SQL

    # Update message count for each community group
    execute <<-SQL
      UPDATE community_groups
      SET message_count = (
        SELECT COUNT(*)
        FROM messages
        WHERE messages.community_group_id = community_groups.id
      )
    SQL
  end

  def down
    execute "DROP MATERIALIZED VIEW IF EXISTS group_message_summary;"
    remove_column :community_groups, :message_count if column_exists?(:community_groups, :message_count)
  end
end

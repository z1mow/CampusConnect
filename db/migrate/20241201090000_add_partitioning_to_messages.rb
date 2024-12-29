class AddPartitioningToMessages < ActiveRecord::Migration[7.0]
  def up
    drop_table :messages, if_exists: true

    execute <<-SQL
      CREATE TABLE messages (
        id BIGSERIAL NOT NULL,
        body TEXT NOT NULL,
        user_id INTEGER NOT NULL,
        community_group_id BIGINT NOT NULL,
        created_at TIMESTAMP NOT NULL,
        updated_at TIMESTAMP NOT NULL,
        PRIMARY KEY (id, created_at)
      ) PARTITION BY RANGE (created_at);
    SQL

    create_partition("messages_dec_2024_to_jan_2025", '2024-12-01', '2025-02-01')
    create_partition("messages_feb_2025_to_mar_2025", '2025-02-01', '2025-04-01')
    create_partition("messages_apr_2025_to_may_2025", '2025-04-01', '2025-06-01')
    create_partition("messages_jun_2025_to_jul_2025", '2025-06-01', '2025-08-01')

    execute <<-SQL
      CREATE TABLE messages_default PARTITION OF messages DEFAULT;
    SQL
  end

  def down
    drop_partition("messages_dec_2024_to_jan_2025")
    drop_partition("messages_feb_2025_to_mar_2025")
    drop_partition("messages_apr_2025_to_may_2025")
    drop_partition("messages_jun_2025_to_jul_2025")
    execute "DROP TABLE IF EXISTS messages_default;"
    execute "DROP TABLE IF EXISTS messages;"
  end

  private

  def create_partition(partition_name, start_date, end_date)
    execute <<-SQL
      CREATE TABLE #{partition_name} PARTITION OF messages
      FOR VALUES FROM ('#{start_date}') TO ('#{end_date}');
    SQL
  end

  def drop_partition(partition_name)
    execute "DROP TABLE IF EXISTS #{partition_name};"
  end
end

CREATE MATERIALIZED VIEW group_message_summary AS
SELECT
    community_group_id,
    COUNT(*) AS total_messages,
    MAX(created_at) AS last_message_time
FROM
    messages
GROUP BY
    community_group_id;

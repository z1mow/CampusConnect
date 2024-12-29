CREATE MATERIALIZED VIEW group_message_summary AS
SELECT
    Community_Group_ID,
    COUNT(*) AS total_messages,
    MAX(Sent_at) AS last_message_time
FROM
    MESSAGES
GROUP BY
    Community_Group_ID;

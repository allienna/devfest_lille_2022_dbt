WITH
    users_stats AS (
        SELECT * FROM {{ ref('dim_users_stats')}})
SELECT badge_count
FROM users_stats
WHERE badge_count < 0
SELECT
    id AS badge_id,
    name AS badge_name,
    date AS award_timestamp,
    user_id
FROM
    `bigquery-public-data.stackoverflow.badges`
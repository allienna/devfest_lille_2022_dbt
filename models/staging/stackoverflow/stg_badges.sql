SELECT
    id AS badge_id,
    name AS badge_name,
    date AS award_timestamp,
    user_id
FROM
    {{ source('stackoverflow', 'badges') }}
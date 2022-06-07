SELECT
    id AS post_id,
    creation_date AS created_at,
    'question' AS type,
    title,
    body,
    owner_user_id,
    parent_id
FROM
    {{ source('stackoverflow', 'posts_questions') }}
WHERE
    -- limit to recent data for the purposes of this demo project
    creation_date >= TIMESTAMP("2023-07-01")
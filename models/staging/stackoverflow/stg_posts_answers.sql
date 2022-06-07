SELECT
    id AS post_id,
    creation_date AS created_at,
    'answer' AS type,
    title,
    body,
    owner_user_id,
    CAST(parent_id AS string) AS parent_id
FROM
    {{ source('stackoverflow', 'posts_answers') }}
WHERE
    -- limit to recent data for the purposes of this demo project
    creation_date >= TIMESTAMP("2023-07-01")
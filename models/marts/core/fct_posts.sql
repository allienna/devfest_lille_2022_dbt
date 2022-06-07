with posts_answers as (
    select * from {{ ref('stg_posts_answers')}}
),
posts_questions as (
    SELECT * FROM {{ ref('stg_posts_questions') }}
)

SELECT
    post_id,
    created_at,
    type,
    title,
    body,
    owner_user_id,
    parent_id
FROM
    posts_answers
UNION ALL
SELECT
    post_id,
    created_at,
    type,
    title,
    body,
    owner_user_id,
    parent_id
FROM
    posts_questions
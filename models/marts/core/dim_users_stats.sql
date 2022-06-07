with users as (
    select * from {{ ref('stg_users')}}
),
     badges as (
         SELECT * FROM {{ ref('stg_badges') }}
     ),
     posts_all AS (
         SELECT * FROM {{ ref('fct_posts') }}
     )

SELECT
    users.user_id,
    users.age,
    users.creation_date,
    users.user_tenure,
    COUNT(DISTINCT badges.badge_id) AS badge_count,
    COUNT(DISTINCT posts_all.post_id) AS questions_and_answer_count,

    {{ count_posts_if('question') }} AS question_count,
    {{ count_posts_if('answer') }} AS answer_count,

    MAX(badges.award_timestamp) AS last_badge_received_at,
    MAX(posts_all.created_at) AS last_posted_at,

    {{ last_posted_post("question")}} AS last_question_posted_at,
    {{ last_posted_post("answer")}} AS last_answer_posted_at,

FROM
    users
    LEFT JOIN badges ON users.user_id = badges.user_id
    LEFT JOIN posts_all ON users.user_id = posts_all.owner_user_id
GROUP BY
    1, 2, 3, 4
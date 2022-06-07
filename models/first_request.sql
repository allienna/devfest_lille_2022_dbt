-- provides an overview of each users engagement:
-- when they signed up, how many badges they have,
-- and how many posts and answers they’ve made.
WITH
    stg_users AS (
        SELECT
            id AS user_id,
            age,
            creation_date,
            ROUND(TIMESTAMP_DIFF(CURRENT_TIMESTAMP(), creation_date, day) / 365) AS user_tenure
        FROM
            `bigquery-public-data.stackoverflow.users`),
    stg_badges AS (
        SELECT
            id AS badge_id,
            name AS badge_name,
    date AS award_timestamp,
    user_id
FROM
    `bigquery-public-data.stackoverflow.badges` ),
    stg_posts_answers AS (
SELECT
    id AS post_id,
    creation_date AS created_at,
    'answer' AS type,
    title,
    body,
    owner_user_id,
    CAST (parent_id AS string) AS parent_id
FROM
    `bigquery-public-data.stackoverflow.posts_answers`
WHERE
-- limit to recent data for the purposes of this demo project
    creation_date >= TIMESTAMP ("2022-01-01") ),
    stg_posts_questions AS (
SELECT
    id AS post_id,
    creation_date AS created_at,
    'question' AS type,
    title,
    body,
    owner_user_id,
    parent_id
FROM
    `bigquery-public-data.stackoverflow.posts_questions`
WHERE
-- limit to recent data for the purposes of this demo project
    creation_date >= TIMESTAMP ("2022-01-01") ),
    posts_combined AS (
SELECT
    post_id,
    created_at,
    type,
    title,
    body,
    owner_user_id,
    parent_id
FROM
    stg_posts_answers
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
    stg_posts_questions )
SELECT
    stg_users.user_id,
    stg_users.age,
    stg_users.creation_date,
    stg_users.user_tenure,
    COUNT(DISTINCT stg_badges.badge_id) AS badge_count,
    COUNT(DISTINCT posts_all.post_id) AS questions_and_answer_count,
    COUNT(DISTINCT
          IF
              (type = "question",
               posts_all.post_id,
               NULL)) AS question_count,
    COUNT(DISTINCT
          IF
              (type = "answer",
               posts_all.post_id,
               NULL)) AS answer_count,
    MAX(stg_badges.award_timestamp) AS last_badge_received_at,
    MAX(posts_all.created_at) AS last_posted_at,
    MAX(
            IF
                (type = "question",
                 posts_all.created_at,
                 NULL)) AS last_question_posted_at,
    MAX(
            IF
                (type = "answer",
                 posts_all.created_at,
                 NULL)) AS last_answer_posted_at
FROM
    stg_users
        LEFT JOIN
    stg_badges
    ON
            stg_users.user_id = stg_badges.user_id
        LEFT JOIN
    posts_combined AS posts_all
    ON
            stg_users.user_id = posts_all.owner_user_id
GROUP BY
    1,
    2,
    3,
    4
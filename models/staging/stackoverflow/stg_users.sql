SELECT
    id AS user_id,
    age,
    creation_date,
    ROUND(TIMESTAMP_DIFF(CURRENT_TIMESTAMP(), creation_date, day)/365) AS user_tenure
FROM
    `bigquery-public-data.stackoverflow.users`
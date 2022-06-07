{% macro last_posted_post(type) %}
    MAX(
        IF
            (type="{{ type }}",
            posts_all.created_at,
            NULL))
{% endmacro %}

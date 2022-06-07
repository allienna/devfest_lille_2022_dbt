{% macro count_posts_if(type, post_id) %}
    COUNT(DISTINCT
          IF
              (type="{{ type}}",
               posts_all.post_id,
               NULL))
{% endmacro %}
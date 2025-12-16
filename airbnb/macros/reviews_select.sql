{% macro reviews_select(relation) -%}
  {%- set cols = adapter.get_columns_in_relation(relation) -%}
  {%- set existing = cols | map(attribute='name') | list -%}

  {%- macro col_or_null(colname, expr, alias) -%}
    {%- if colname in existing -%}
      {{ expr }} as {{ adapter.quote(alias) }}
    {%- else -%}
      null as {{ adapter.quote(alias) }}
    {%- endif -%}
  {%- endmacro -%}

  {{ col_or_null('id',
      "try_to_number(" ~ adapter.quote('id') ~ ")",
      'review_id') }},

  {{ col_or_null('listing_id',
      "try_to_number(" ~ adapter.quote('listing_id') ~ ")",
      'listing_id') }},

  {{ col_or_null('date',
      "try_to_date(" ~ adapter.quote('date') ~ ")",
      'review_date') }},

  {{ col_or_null('reviewer_id',
      "try_to_number(" ~ adapter.quote('reviewer_id') ~ ")",
      'reviewer_id') }},

  {{ col_or_null('reviewer_name',
      "nullif(trim(" ~ adapter.quote('reviewer_name') ~ "), '')",
      'reviewer_name') }},

  {{ col_or_null('comments',
      adapter.quote('comments'),
      'comments') }}
{%- endmacro %}

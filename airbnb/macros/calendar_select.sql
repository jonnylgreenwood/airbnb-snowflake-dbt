{% macro calendar_select(relation) -%}
  {%- set cols = adapter.get_columns_in_relation(relation) -%}
  {%- set existing = cols | map(attribute='name') | list -%}

  {{ col_or_null(existing, 'listing_id', adapter.quote('listing_id'), 'listing_id') }},
  {{ col_or_null(existing, 'date', "to_date(" ~ adapter.quote('date') ~ ")", 'date') }},
  {{ col_or_null(existing, 'available', adapter.quote('available'), 'available') }},
  {{ col_or_null(existing, 'price', "try_to_decimal(regexp_replace(" ~ adapter.quote('price') ~ ", '[^0-9\\.\\-]', ''), 10, 2)", 'price') }},
  {{ col_or_null(existing, 'adjusted_price', "try_to_decimal(regexp_replace(" ~ adapter.quote('adjusted_price') ~ ", '[^0-9\\.\\-]', ''), 10, 2)", 'adjusted_price') }},
  {{ col_or_null(existing, 'minimum_nights', "try_to_number(" ~ adapter.quote('minimum_nights') ~ ")", 'minimum_nights') }},
  {{ col_or_null(existing, 'maximum_nights', "try_to_number(" ~ adapter.quote('maximum_nights') ~ ")", 'maximum_nights') }}
{%- endmacro %}

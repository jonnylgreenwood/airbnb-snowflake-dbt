{% macro calendar_select(relation) -%}
  {%- set cols = adapter.get_columns_in_relation(relation) -%}
  {%- set existing = cols | map(attribute='name') | list -%}

  {# helper to emit either an expression or null #}
  {%- macro col_or_null(colname, expr, alias) -%}
    {%- if colname in existing -%}
      {{ expr }} as {{ adapter.quote(alias) }}
    {%- else -%}
      null as {{ adapter.quote(alias) }}
    {%- endif -%}
  {%- endmacro -%}

  {{ col_or_null('listing_id', adapter.quote('listing_id'), 'listing_id') }},
  {{ col_or_null('date', "to_date(" ~ adapter.quote('date') ~ ")", 'date') }},
  {{ col_or_null('available', adapter.quote('available'), 'available') }},
  {{ col_or_null('price', "try_to_decimal(regexp_replace(" ~ adapter.quote('price') ~ ", '[^0-9\\.\\-]', ''), 10, 2)", 'price') }},
  {{ col_or_null('adjusted_price', "try_to_decimal(regexp_replace(" ~ adapter.quote('adjusted_price') ~ ", '[^0-9\\.\\-]', ''), 10, 2)", 'adjusted_price') }},
  {{ col_or_null('minimum_nights', "try_to_number(" ~ adapter.quote('minimum_nights') ~ ")", 'minimum_nights') }},
  {{ col_or_null('maximum_nights', "try_to_number(" ~ adapter.quote('maximum_nights') ~ ")", 'maximum_nights') }}
{%- endmacro %}

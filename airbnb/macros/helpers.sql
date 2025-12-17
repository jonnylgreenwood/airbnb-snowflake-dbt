{% macro try_parse_money(colname) -%}
  try_to_decimal(regexp_replace({{ adapter.quote(colname) }}, '[^0-9\.\-]', ''), 10, 2)
{%- endmacro %}

{% macro try_parse_percent(colname) -%}
  -- "98%" -> 0.98 ; "98" -> 0.98 ; null stays null
  case
    when {{ adapter.quote(colname) }} is null then null
    else try_to_decimal(regexp_replace({{ adapter.quote(colname) }}, '[^0-9\.\-]', ''), 10, 2) / 100
  end
{%- endmacro %}

{% macro snapshot_date_from_relation(relation) -%}
  {%- set name = relation.identifier -%}
  {%- set datestr = name[-8:] -%}
  to_date('{{ datestr }}', 'YYYYMMDD')
{%- endmacro %}

{% macro col_or_null(existing, colname, expr, alias) -%}
  {%- if colname in existing -%}
    {{ expr }} as {{ alias }}
  {%- else -%}
    null as {{ alias }}
  {%- endif -%}
{%- endmacro %}

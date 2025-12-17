{% macro reviews_select(relation) -%}
  try_to_number({{ adapter.quote("id") }})           as review_id,
  try_to_number({{ adapter.quote("listing_id") }})   as listing_id,
  try_to_date({{ adapter.quote("date") }})           as review_date,
  try_to_number({{ adapter.quote("reviewer_id") }})  as reviewer_id,
  nullif(trim({{ adapter.quote("reviewer_name") }}), '') as reviewer_name,
  {{ adapter.quote("comments") }}                    as comments
{%- endmacro %}

{%- set ams = source('l0', 'raw__amsterdam__listings__20250911') -%}
{%- set par = source('l0', 'raw__paris__listings__20250912') -%}
{%- set bcn = source('l0', 'raw__barcelona__listings__20250914') -%}
{%- set lon = source('l0', 'raw__london__listings__20250914') -%}
{%- set lis = source('l0', 'raw__lisbon__listings__20250921') -%}

select
  'amsterdam' as city,
  {{ snapshot_date_from_relation(ams) }} as snapshot_date,
  {{ listings_select(ams) }}
from {{ ams }}

union all
select
  'paris' as city,
  {{ snapshot_date_from_relation(par) }} as snapshot_date,
  {{ listings_select(par) }}
from {{ par }}

union all
select
  'barcelona' as city,
  {{ snapshot_date_from_relation(bcn) }} as snapshot_date,
  {{ listings_select(bcn) }}
from {{ bcn }}

union all
select
  'london' as city,
  {{ snapshot_date_from_relation(lon) }} as snapshot_date,
  {{ listings_select(lon) }}
from {{ lon }}

union all
select
  'lisbon' as city,
  {{ snapshot_date_from_relation(lis) }} as snapshot_date,
  {{ listings_select(lis) }}
from {{ lis }}

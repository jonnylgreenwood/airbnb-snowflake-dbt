{%- set ams = source('l0', 'raw__amsterdam__calendar__20250911') -%}
{%- set par = source('l0', 'raw__paris__calendar__20250912') -%}
{%- set bar = source('l0', 'raw__barcelona__calendar__20250914') -%}
{%- set lon = source('l0', 'raw__london__calendar__20250914') -%}
{%- set lis = source('l0', 'raw__lisbon__calendar__20250921') -%}

select
  'amsterdam' as city,
  {{ snapshot_date_from_relation(ams) }} as snapshot_date,
  {{ calendar_select(ams) }}
from {{ ams }}

UNION ALL
select
  'barcelona' as city,
  {{ snapshot_date_from_relation(bar) }} as snapshot_date,
  {{ calendar_select(bar) }}
from {{ bar }}
UNION ALL
select
  'paris' as city,
  {{ snapshot_date_from_relation(par) }} as snapshot_date,
  {{ calendar_select(par) }}
from {{ par }}
UNION ALL
select
  'lisbon' as city,
  {{ snapshot_date_from_relation(lis) }} as snapshot_date,
  {{ calendar_select(lis) }}
from {{ lis }}
UNION ALL
select
  'london' as city,
  {{ snapshot_date_from_relation(lon) }} as snapshot_date,
  {{ calendar_select(lon) }}
from {{ lon }}
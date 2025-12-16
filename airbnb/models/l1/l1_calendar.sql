SELECT
  'amsterdam' AS city,
  DATE '2025-09-11' AS snapshot_date,
  *
FROM {{ source('l0', 'raw__amsterdam__calendar__20250911') }}

UNION ALL
SELECT
  'paris',
  DATE '2025-09-12',
  *
FROM {{ source('l0', 'raw__paris__calendar__20250912') }}

UNION ALL
SELECT
  'barcelona',
  DATE '2025-09-14',
  *
FROM {{ source('l0', 'raw__barcelona__calendar__20250914') }}

UNION ALL
SELECT
  'london',
  DATE '2025-09-14',
  *
FROM {{ source('l0', 'raw__london__calendar__20250914') }}

UNION ALL
SELECT
  'lisbon',
  DATE '2025-09-21',
  *
FROM {{ source('l0', 'raw__lisbon__calendar__20250921') }}
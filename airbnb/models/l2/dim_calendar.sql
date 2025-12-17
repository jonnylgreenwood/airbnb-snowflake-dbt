with bounds as (
    select
        min("DATE") as min_date,
        max("DATE") as max_date
    from {{ ref('l1_calendar') }}
),

dates as (
    select
        dateadd(day, seq4(), b.min_date) as "DATE"
    from bounds b,
         table(generator(rowcount => 10000))  -- big enough
    where dateadd(day, seq4(), b.min_date) <= b.max_date
)

select
    "DATE"                                       as "DATE",
    year("DATE")                                 as "YEAR",
    month("DATE")                                as "MONTH",
    monthname("DATE")                            as "MONTH_NAME",
    day("DATE")                                  as "DAY",
    dayofweekiso("DATE")                         as "DAY_OF_WEEK",
    weekofyear("DATE")                           as "WEEK_OF_YEAR",
    quarter("DATE")                              as "QUARTER",
    iff(dayofweekiso("DATE") in (6,7), true, false) as "IS_WEEKEND"
from dates
order by "DATE"
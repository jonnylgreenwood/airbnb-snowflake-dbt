select
    c.city,
    l.neighbourhood_cleansed,
    date_trunc('month', c.date) as month_start,

    count_if(lower(c.available) = 'f') as booked_days,
    count_if(lower(c.available) = 't') as available_days,
    count(*)                            as total_days,

    count_if(lower(c.available) = 'f')::float
        / nullif(count(*), 0)           as occupancy_rate

from {{ ref('fct_calendar') }} c
join {{ ref('dim_listings') }} l
  on c.listing_id = l.listing_id

-- Optional: latest snapshot only
-- where c.snapshot_date = (select max(snapshot_date) from {{ ref('fct_calendar') }})

group by
    c.city,
    l.neighbourhood_cleansed,
    month_start

order by
    c.city,
    l.neighbourhood_cleansed,
    month_start
select
    city,
    neighbourhood_cleansed,

    count(distinct listing_id) as total_properties,

    avg(
        try_to_decimal(
            regexp_replace(price::string, '[^0-9\\.]', ''),
            10, 2
        )
    ) as average_price

from {{ ref('dim_listings') }}
group by
    city,
    neighbourhood_cleansed
order by
    city,
    neighbourhood_cleansed
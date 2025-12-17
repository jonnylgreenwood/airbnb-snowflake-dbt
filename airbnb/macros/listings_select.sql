{% macro listings_select(relation) -%}
  {%- set cols = adapter.get_columns_in_relation(relation) -%}
  {%- set existing = cols | map(attribute='name') | list -%}



  {{ col_or_null(existing, 'id', adapter.quote('id'), 'listing_id') }},
  {{ col_or_null(existing, 'listing_url', adapter.quote('listing_url'), 'listing_url') }},
  {{ col_or_null(existing, 'name', "nullif(trim(" ~ adapter.quote('name') ~ "), '')", 'name') }},
  {{ col_or_null(existing, 'source', adapter.quote('source'), 'source') }},
  {{ col_or_null(existing, 'last_scraped', "try_to_date(" ~ adapter.quote('last_scraped') ~ ")", 'last_scraped') }},
  {{ col_or_null(existing, 'last_review', "try_to_date(" ~ adapter.quote('last_review') ~ ")", 'last_review') }},

  {{ col_or_null(existing, 'latitude', "try_to_double(" ~ adapter.quote('latitude') ~ ")", 'latitude') }},
  {{ col_or_null(existing, 'longitude', "try_to_double(" ~ adapter.quote('longitude') ~ ")", 'longitude') }},
  {{ col_or_null(existing, 'license', "nullif(trim(" ~ adapter.quote('license') ~ "), '')", 'license') }},

  {{ col_or_null(existing, 'property_type', "nullif(trim(" ~ adapter.quote('property_type') ~ "), '')", 'property_type') }},
  {{ col_or_null(existing, 'room_type', "nullif(trim(" ~ adapter.quote('room_type') ~ "), '')", 'room_type') }},

  {{ col_or_null(existing, 'neighbourhood', "nullif(trim(" ~ adapter.quote('neighbourhood') ~ "), '')", 'neighbourhood') }},
  {{ col_or_null(existing, 'neighbourhood_cleansed', "nullif(trim(" ~ adapter.quote('neighbourhood_cleansed') ~ "), '')", 'neighbourhood_cleansed') }},
  {{ col_or_null(existing, 'neighbourhood_group_cleansed', "nullif(trim(" ~ adapter.quote('neighbourhood_group_cleansed') ~ "), '')", 'neighbourhood_group_cleansed') }},
  {{ col_or_null(existing, 'neighborhood_overview', "nullif(trim(" ~ adapter.quote('neighborhood_overview') ~ "), '')", 'neighborhood_overview') }},

  {%- if 'price' in existing -%}
    coalesce(
      {{ try_parse_money('price') }},
      try_to_decimal(
        regexp_replace(to_varchar({{ adapter.quote('price') }}), '[^0-9\.\-]', ''),
        10, 2
      )
    ) as price
  {%- else -%}
    null as price
  {%- endif -%},

  {{ col_or_null(existing, 'instant_bookable',
      "case when lower(" ~ adapter.quote('instant_bookable') ~ ") in ('t','true','1','yes','y') then true "
      ~ "when lower(" ~ adapter.quote('instant_bookable') ~ ") in ('f','false','0','no','n') then false "
      ~ "else null end",
      'instant_bookable') }},

  {{ col_or_null(existing, 'host_url', adapter.quote('host_url'), 'host_url') }},
  {{ col_or_null(existing, 'host_since', "try_to_date(" ~ adapter.quote('host_since') ~ ")", 'host_since') }},
  {{ col_or_null(existing, 'host_total_listings_count', "try_to_double(" ~ adapter.quote('host_total_listings_count') ~ ")", 'host_total_listings_count') }},
  {{ col_or_null(existing, 'host_response_time', "nullif(trim(" ~ adapter.quote('host_response_time') ~ "), '')", 'host_response_time') }},
  {{ col_or_null(existing, 'host_response_rate', try_parse_percent('host_response_rate'), 'host_response_rate') }},
  {{ col_or_null(existing, 'host_verifications', adapter.quote('host_verifications'), 'host_verifications') }},
  {{ col_or_null(existing, 'host_thumbnail_url', adapter.quote('host_thumbnail_url'), 'host_thumbnail_url') }},
  {{ col_or_null(existing, 'host_picture_url', adapter.quote('host_picture_url'), 'host_picture_url') }},

  {{ col_or_null(existing, 'picture_url', adapter.quote('picture_url'), 'picture_url') }},

  {{ col_or_null(existing, 'minimum_nights', "try_to_number(" ~ adapter.quote('minimum_nights') ~ ")", 'minimum_nights') }},
  {{ col_or_null(existing, 'maximum_nights', "try_to_number(" ~ adapter.quote('maximum_nights') ~ ")", 'maximum_nights') }},
  {{ col_or_null(existing, 'minimum_minimum_nights', "try_to_double(" ~ adapter.quote('minimum_minimum_nights') ~ ")", 'minimum_minimum_nights') }},
  {{ col_or_null(existing, 'maximum_minimum_nights', "try_to_double(" ~ adapter.quote('maximum_minimum_nights') ~ ")", 'maximum_minimum_nights') }},
  {{ col_or_null(existing, 'minimum_maximum_nights', "try_to_double(" ~ adapter.quote('minimum_maximum_nights') ~ ")", 'minimum_maximum_nights') }},
  {{ col_or_null(existing, 'maximum_maximum_nights', "try_to_double(" ~ adapter.quote('maximum_maximum_nights') ~ ")", 'maximum_maximum_nights') }},
  {{ col_or_null(existing, 'minimum_nights_avg_ntm', "try_to_double(" ~ adapter.quote('minimum_nights_avg_ntm') ~ ")", 'minimum_nights_avg_ntm') }},
  {{ col_or_null(existing, 'maximum_nights_avg_ntm', "try_to_double(" ~ adapter.quote('maximum_nights_avg_ntm') ~ ")", 'maximum_nights_avg_ntm') }},

  {{ col_or_null(existing, 'number_of_reviews', "try_to_number(" ~ adapter.quote('number_of_reviews') ~ ")", 'number_of_reviews') }},
  {{ col_or_null(existing, 'number_of_reviews_ltm', "try_to_number(" ~ adapter.quote('number_of_reviews_ltm') ~ ")", 'number_of_reviews_ltm') }},
  {{ col_or_null(existing, 'number_of_reviews_l30d', "try_to_number(" ~ adapter.quote('number_of_reviews_l30d') ~ ")", 'number_of_reviews_l30d') }},
  {{ col_or_null(existing, 'number_of_reviews_ly', "try_to_number(" ~ adapter.quote('number_of_reviews_ly') ~ ")", 'number_of_reviews_ly') }},
  {{ col_or_null(existing, 'reviews_per_month', "try_to_double(" ~ adapter.quote('reviews_per_month') ~ ")", 'reviews_per_month') }},

  {{ col_or_null(existing, 'review_scores_rating', "try_to_double(" ~ adapter.quote('review_scores_rating') ~ ")", 'review_scores_rating') }},
  {{ col_or_null(existing, 'review_scores_accuracy', "try_to_double(" ~ adapter.quote('review_scores_accuracy') ~ ")", 'review_scores_accuracy') }},
  {{ col_or_null(existing, 'review_scores_cleanliness', "try_to_double(" ~ adapter.quote('review_scores_cleanliness') ~ ")", 'review_scores_cleanliness') }},
  {{ col_or_null(existing, 'review_scores_checkin', "try_to_double(" ~ adapter.quote('review_scores_checkin') ~ ")", 'review_scores_checkin') }},
  {{ col_or_null(existing, 'review_scores_communication', "try_to_double(" ~ adapter.quote('review_scores_communication') ~ ")", 'review_scores_communication') }},
  {{ col_or_null(existing, 'review_scores_location', "try_to_double(" ~ adapter.quote('review_scores_location') ~ ")", 'review_scores_location') }},
  {{ col_or_null(existing, 'review_scores_value', "try_to_double(" ~ adapter.quote('review_scores_value') ~ ")", 'review_scores_value') }}
{%- endmacro %}

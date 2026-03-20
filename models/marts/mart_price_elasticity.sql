select
    ut.project_id,
    ut.unit_type,
    ut.suburb,
    ut.unit_type_count,
    ut.unit_avg_price_per_sqm,
    p.project_avg_price_per_sqm,
    ut.unit_stddev,
    p.project_stddev,
    ut.min_price_per_sqm,
    ut.max_price_per_sqm,
    unit_avg_price_per_sqm - project_avg_price_per_sqm as price_premium_dollar,
    ROUND((unit_avg_price_per_sqm - project_avg_price_per_sqm) / project_avg_price_per_sqm * 100, 2) as price_premium_percent,
    ROUND(unit_stddev / unit_avg_price_per_sqm, 4) as coefficient_of_variation,
    ROUND((unit_avg_price_per_sqm - project_avg_price_per_sqm) / project_stddev, 4) as z_score
from {{ ref('int_unit_type_pricing') }} ut
join {{ ref('int_project_avg_pricing') }} p 
on ut.project_id = p.project_id
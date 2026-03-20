select
    project_id,
    suburb,
    ROUND(AVG(price_per_sqm), 2) as project_avg_price_per_sqm,
    COUNT(*) as total_num_units,
    ROUND(STDDEV(price_per_sqm), 2) as project_stddev,
    MIN(price_per_sqm) as min_price_per_sqm,
    MAX(price_per_sqm) as max_price_per_sqm,
from {{ ref('stg_property_development__pricing') }}
GROUP BY project_id, suburb
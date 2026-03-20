select
    project_id,
    unit_type,
    suburb,
    ROUND(AVG(price_per_sqm), 2) as unit_avg_price_per_sqm,
    COUNT(*) as unit_type_count,
    ROUND(STDDEV(price_per_sqm), 2) as unit_stddev,
    MIN(price_per_sqm) as min_price_per_sqm,
    MAX(price_per_sqm) as max_price_per_sqm
from {{ ref('stg_property_development__pricing') }}
GROUP BY project_id, unit_type, suburb
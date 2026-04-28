select
    project_id,
    COUNT(DISTINCT unit_id) as units_sold,
    MODE(property_type) as property_type,
    MAX(total_revenue) as total_revenue,
    ROUND(AVG(price_per_sqm), 2) as avg_price_per_sqm,
    ROUND(AVG(final_sale_price), 2) as avg_sale_price_per_unit
from {{ ref('stg_property_development__projects') }}
GROUP BY project_id
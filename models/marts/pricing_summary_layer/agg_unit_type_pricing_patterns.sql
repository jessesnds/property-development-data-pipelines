select
    unit_type,
    COUNT(*) as unit_type_count,
    suburb,
    ROUND(AVG(price_premium_dollar), 2) as avg_price_premium_dollar,
    ROUND(AVG(price_premium_percent), 2) as avg_price_premium_pct,
    ROUND(AVG(coefficient_of_variation), 4) as avg_coefficient_of_variation,
    MAX(coefficient_of_variation) as max_coefficient_of_variation,
    AVG(CASE 
            WHEN price_premium_percent > 0 THEN 1 
            ELSE 0  
        END
        ) * 100 AS premium_frequency_pct
from {{ ref('mart_price_elasticity') }}
group by unit_type, suburb

select
    unit_id,
    project_id,
    unit_type,
    suburb,
    property_type,
    final_sale_price,
    internal_area_sqm,
    price_per_sqm,
    settlement_date
from {{ source('DEV_DATA', 'DEV_DETAILS') }}
where final_sale_price > 0 AND internal_area_sqm > 0
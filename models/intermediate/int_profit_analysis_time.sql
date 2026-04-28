select
    project_id,
    COUNT(*) as unit_count,
    MODE(property_type) as property_type,
    MAX(land_acquisition_date) as land_acquisition_date,
    MAX(da_approval_days) as da_approval_days,
    MAX(construction_start_date) as construction_start_date,
    MAX(planned_construction_months) as planned_construction_months,
    MAX(actual_construction_months) as actual_construction_months,
    MAX(delay_months) as delay_months,
    MAX(construction_completion_date) as construction_completion_date    
from {{ ref('stg_property_development__projects') }}
GROUP BY project_id
select
    project_id,
    COUNT(*) as unit_count,
    MODE(property_type) as property_type,
    MAX(planned_construction_cost) as planned_construction_cost,
    MAX(actual_construction_cost) as actual_construction_cost,
    MAX(total_defect_costs) as total_defect_costs,
    ROUND(MAX(total_project_cost), 2) as total_project_cost,
    MAX(total_land_cost) as total_land_cost,
from {{ ref('stg_property_development__projects') }}
GROUP BY project_id
select
    unit_id,
    project_id,
    developer,
    suburb,
    has_defect,
    defect_type,
    defect_cost,
    warranty_claim_date,
    property_type,
    num_units
from {{ source('DEV_DATA', 'DEV_DETAILS') }}
where has_defect = true
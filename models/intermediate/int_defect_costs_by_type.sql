select
    defect_type,
    count(*) as defect_count,
    sum(defect_cost) as total_cost,
    avg(defect_cost) as avg_cost
from {{ ref('stg_property_development__defect') }}
group by defect_type
order by total_cost desc
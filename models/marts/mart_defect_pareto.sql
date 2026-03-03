with defect_totals as (
    select
        defect_type,
        defect_count,
        total_cost,
        avg_cost
    from {{ ref('int_defect_costs_by_type') }}
),

pareto_calc as (
    select
        defect_type,
        defect_count,
        total_cost,
        avg_cost,
        sum(total_cost) over () as grand_total_cost,
        sum(defect_count) over () as grand_total_defects,
        sum(total_cost) over (
            order by total_cost desc
            rows between unbounded preceding and current row
        ) as cumulative_cost
    from defect_totals
)

select
    defect_type,
    defect_count,
    total_cost,
    avg_cost,
    grand_total_cost,
    cumulative_cost,
    round(total_cost / grand_total_cost * 100, 2) as pct_of_total_cost,
    round(defect_count / grand_total_defects * 100, 2) as pct_of_total_defects,
    round(cumulative_cost / grand_total_cost * 100, 2) as cumulative_cost_pct
from pareto_calc
order by total_cost desc
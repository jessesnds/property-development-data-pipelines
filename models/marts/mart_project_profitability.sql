WITH financial_metrics AS (
    select
        r.project_id,
        r.property_type,
        r.units_sold,
        c.total_project_cost,
        r.total_revenue - c.total_project_cost as net_profit,
        ROUND(((r.total_revenue - c.total_project_cost) / NULLIF(c.total_project_cost, 0)) * 100, 2) as roi_pct,
        ROUND(((r.total_revenue - c.total_project_cost) / NULLIF(r.total_revenue, 0 )) * 100, 2) as profit_margin_pct,
        CASE WHEN c.total_project_cost IS NULL THEN TRUE ELSE FALSE END as is_missing_cost_data
    from {{ ref('int_profit_analysis_revenue') }} r
    left join {{ ref('int_profit_analysis_cost') }} c
    on r.project_id = c.project_id
    
),
project_duration AS (
    select
        project_id,
        DATEDIFF(day, construction_start_date, construction_completion_date) as duration_days,
        CASE WHEN construction_completion_date IS NOT NULL THEN TRUE ELSE FALSE END as is_completed
    from {{ ref('int_profit_analysis_time') }}
    

),
annualised_return AS (
    select
        f.project_id,
        f.net_profit,
        f.total_project_cost,
        t.duration_days,
        ROUND((f.net_profit / NULLIF(f.total_project_cost, 0)) 
            / NULLIF(t.duration_days / 365.0, 0), 2) as annualised_return
    from financial_metrics f
    left join project_duration t
        on f.project_id = t.project_id
)
select
    f.project_id,
    f.property_type,
    f.units_sold,
    f.net_profit,
    f.roi_pct,
    f.profit_margin_pct,
    a.annualised_return,
    t.duration_days,
    t.is_completed,
    f.is_missing_cost_data
from financial_metrics f
left join project_duration t
    on f.project_id = t.project_id
 left join annualised_return a
    on t.project_id = a.project_id
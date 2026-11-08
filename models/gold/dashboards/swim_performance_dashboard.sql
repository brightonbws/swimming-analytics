select
    m.event_id,
    min(m.time_seconds) fastest_time,
    g.target_date,
    g.target_seconds,
    g.goal_type

from {{ ref("stg_meet_results") }} m

join {{ ref("goal_targets") }} g on m.event_id = g.event_id

group by
    m.event_id,
    g.target_date,
    g.target_seconds,
    g.goal_type

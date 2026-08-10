select
    m.event_id,
    m.time_seconds,
    g.target_date,
    g.target_seconds,
    g.goal_type

from {{ ref("stg_meet_results") }} m

join {{ ref("goal_targets") }} g on m.event_id = g.event_id

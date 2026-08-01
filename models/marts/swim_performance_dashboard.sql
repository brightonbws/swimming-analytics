select
    m.event,
    m.time as current_time,
    g.next_meet_goal,
    g.three_month_goal,
    g.six_month_goal,
    g.twelve_month_goal,
    g.reach_goal

from {{ ref('stg_meet_results') }} m

join {{ ref('event_goals') }} g
    on m.event = g.event
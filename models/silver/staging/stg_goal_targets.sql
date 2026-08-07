select
    {{ dbt_utils.generate_surrogate_key([
        'season',
        'event_id',
        'target_date',
        'goal_type'
    ]) }} as goal_target_id,
    *
from
    {{ ref("goal_targets") }}

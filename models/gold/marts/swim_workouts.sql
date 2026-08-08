select
    workout_id,
    workout_date,
    workout_type,
    training_phase,
    duration_minutes,
    distance_yards,
        sum(distance_yards) over (
        order by workout_date
        rows between unbounded preceding and current row
    ) as running_total_yards,

    sum(distance_yards) over (
        partition by year_month
        order by workout_date
        rows between unbounded preceding and current row
    ) as monthly_running_yards
from
    {{ ref("int_workout_metrics") }}
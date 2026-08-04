select
    workout_id,
    workout_date,
    workout_type,
    duration_minutes,
    distance_yards,
    ROUND(avg_heart_rate, 2),
    ROUND(max_heart_rate, 2),
    ROUND(active_calories, 2),
    stroke_count,
    swolf_score,
    yards_per_minute,
    seconds_per_100_yards
from {{ ref("int_workout_metrics") }}

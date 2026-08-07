select
    workout_id,
    workout_date,
    workout_type,
    duration_minutes,
    distance_yards,
    ROUND(avg_heart_rate, 2) as average_hr,
    ROUND(max_heart_rate, 2) as max_hr,
    ROUND(active_calories, 2) as active_calores,
    stroke_count,
    swolf_score,
    yards_per_minute,
    seconds_per_100_yards
from {{ ref("int_workout_metrics") }}

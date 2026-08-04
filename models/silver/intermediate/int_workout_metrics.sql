{{ config(materialized="view") }}

with workouts as (select * from {{ ref("stg_apple_health_workouts") }})

select

    *,
    -- Duration
    unix_timestamp(workout_end_ts)
    - unix_timestamp(workout_start_ts) as duration_seconds,
    round(
        (unix_timestamp(workout_end_ts) - unix_timestamp(workout_start_ts)) / 60.0, 2
    ) as duration_minutes,
    -- Distance
    round(distance_miles * 1760, 0) as distance_yards,
    round(distance_miles * 1609.344, 2) as distance_meters,
    -- Pace
    round(
        (unix_timestamp(workout_end_ts) - unix_timestamp(workout_start_ts))
        / (distance_miles * 17.6),
        2
    ) as seconds_per_100_yards,
    round(
        (distance_miles * 1760)
        / ((unix_timestamp(workout_end_ts) - unix_timestamp(workout_start_ts)) / 60.0),
        2
    ) as yards_per_minute,
    -- Calories
    round(active_calories / (distance_miles * 1760), 3) as calories_per_yard,
    round(active_calories / (distance_miles * 17.6), 2) as calories_per_100_yards,
    -- Stroke Metrics
    round(stroke_count / (distance_miles * 70.4), 2) as strokes_per_25,
    round(stroke_count / (distance_miles * 17.6), 2) as strokes_per_100,
    -- Calendar
    date(workout_start_ts) as workout_date,
    year(workout_start_ts) as workout_year,
    month(workout_start_ts) as workout_month,
    weekofyear(workout_start_ts) as workout_week,
    date_format(workout_start_ts, 'EEEE') as day_of_week

from workouts

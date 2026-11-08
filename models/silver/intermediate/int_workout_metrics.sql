{{ config(materialized="view") }}

with workouts as (select * from {{ ref("stg_apple_health_workouts") }})

select
    workout_id,

    -- Workout Information
    workout_type,
    workout_start_ts,
    workout_end_ts,
    training_phase,

    -- Duration
    duration,

    -- Calories
    ROUND(active_calories, 1) as active_calories,
    ROUND(resting_calories, 1) as resting_calories,
    ROUND(intensity_kcal_hr_kg, 1) as intensity_kcal_hr_kg,

    -- Heart Rate
    ROUND(max_heart_rate, 1) as max_heart_rate,
    ROUND(avg_heart_rate, 1) as avg_heart_rate,

    -- Distance
    ROUND(distance_miles, 2) as distance_miles,

    -- Speed
    ROUND(max_speed_mph, 2) as max_speed_mph,
    ROUND(avg_speed_mph, 2) as avg_speed_mph,

    -- Elevation
    flights_climbed,
    elevation_ascended_ft,
    elevation_descended_ft,

    -- Steps
    step_count,
    step_cadence,

    -- Swimming
    stroke_count,
    ROUND(swim_cadence, 2) as swim_cadence,
    ROUND(lap_length_yards, 2) as lap_length_yards,
    swim_stroke_style,
    swolf_score,

    -- Environment
    water_salinity,
    ROUND(temperature_f, 2) as temperature_f,
    ROUND(humidity_pct, 2) as humidity_pct,
    location,

    -- Duration
    unix_timestamp(workout_end_ts) - unix_timestamp(workout_start_ts) as duration_seconds,
    round(
        (unix_timestamp(workout_end_ts) - unix_timestamp(workout_start_ts)) / 60.0, 2
    ) as duration_minutes,
    -- Distance
    case
    when distance_miles > 10 then distance_miles
    else distance_miles * 1760
    end as distance_yards,
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
    DATE_FORMAT(workout_start_ts, 'yyyy_MM') as year_month,
    month(workout_start_ts) as workout_month,
    weekofyear(workout_start_ts) as workout_week,
    date_format(workout_start_ts, 'EEEE') as day_of_week

from workouts

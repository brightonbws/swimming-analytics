{{ config(materialized="view") }}

select
    {{
        dbt_utils.generate_surrogate_key(
            ["Start", "End", "`Workout Type`", "Duration"]
        )
    }} as workout_id,

    -- Workout Information
    `Workout Type` as workout_type,
    case
    when date(`Start`) < date('2026-08-03') then 'return_to_swimming'
    else '8_week_program'
    end as training_phase,

    cast(`Start` as timestamp) as workout_start_ts,
    cast(`End` as timestamp) as workout_end_ts,

    -- Duration
    cast(`Duration` as string) as duration,

    -- Calories
    cast(`Active Energy (kcal)` as double) as active_calories,
    cast(`Resting Energy (kcal)` as double) as resting_calories,
    cast(`Intensity (kcal/hr·kg)` as double) as intensity_kcal_hr_kg,

    -- Heart Rate
    cast(`Max. Heart Rate (bpm)` as int) as max_heart_rate,
    cast(`Avg. Heart Rate (bpm)` as double) as avg_heart_rate,

    -- Distance
    cast(`Distance (mi)` as double) as distance_miles,

    -- Speed
    cast(`Max. Speed (mi/hr)` as double) as max_speed_mph,
    cast(`Avg. Speed (mi/hr)` as double) as avg_speed_mph,

    -- Elevation
    cast(`Flights Climbed` as int) as flights_climbed,
    cast(`Elevation Ascended (ft)` as double) as elevation_ascended_ft,
    cast(`Elevation Descended (ft)` as double) as elevation_descended_ft,

    -- Steps
    cast(`Step Count` as int) as step_count,
    cast(`Step Cadence (spm)` as double) as step_cadence,

    -- Swimming
    cast(`Swimming Stroke Count` as int) as stroke_count,
    cast(`Swim Cadence (spm)` as double) as swim_cadence,
    cast(`Lap Length (yd)` as double) as lap_length_yards,
    `Swim Stroke Style` as swim_stroke_style,
    cast(`SWOLF Score` as double) as swolf_score,

    -- Environment
    `Water Salinity` as water_salinity,
    cast(`Temperature (ºF)` as double) as temperature_f,
    cast(`Humidity (%)` as double) as humidity_pct,
    `Location` as location

from {{ ref("bronze_apple_health_workouts") }}

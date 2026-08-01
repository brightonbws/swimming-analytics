with source as (

    select *
    from {{ ref('meet_results') }}

),

cleaned as (

    select
        cast(meet_date as date) as meet_date,
        meet_name,
        event,
        stroke,
        distance,
        time,
        course,
        notes

    from source

)

select *
from cleaned
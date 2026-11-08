with
    meet_results as (select * from {{ ref("meet_results") }}),

    meet_info as (select * from {{ ref("dim_meets")}} ),

    combined as (

        select
            mi.start_date as meet_date,
            mi.meet_name,
            mr.event_id,
            mr.time_seconds,
            mr.notes

        from meet_results as mr 
        join meet_info as mi 
        on mr.meet_id = mi.meet_id

    )

select *
from combined

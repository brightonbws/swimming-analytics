with
    source as (select * from {{ ref("meet_results") }}),

    cleaned as (

        select
            cast(meet_date as date) as meet_date,
            meet_name,
            event_id,
            time,
            notes

        from source

    )

select *
from cleaned

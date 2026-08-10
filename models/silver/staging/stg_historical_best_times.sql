select
    season,
    event_id,
    time_seconds,
    notes
from
    {{ ref("historical_best_times") }}
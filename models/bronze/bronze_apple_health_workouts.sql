select *
from
    read_files(
        '/Volumes/swimming/dev/apple_health_data/*.csv', format => 'csv', header => true
    )

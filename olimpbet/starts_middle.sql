SELECT
    co as num_starts,
    count() as count
    FROM (
             SELECT countIf(type = 'start') as co
             FROM (
                      SELECT *
                      FROM events_parsed
                      WHERE project_id = 'prod-405'
                        AND toDate(timestamp) >= '2023-05-01'
                      ORDER BY ts_ms
                      )
             GROUP BY user_id
             )
GROUP BY co
ORDER BY co
;
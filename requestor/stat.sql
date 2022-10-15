-- Funnel messages
WITH
    '2022-09-01 00:00:00' as startTime,
    '2022-09-02 00:00:00' as endTime,
    'prod-137' as project
SELECT
    n_messages,
    cnt,
    neighbor(cnt, 1) as keeps,
    cnt-keeps as terminates,
    round(keeps/cnt*100, 2) as keeps_pct,
    round(terminates/cnt*100, 2) as terminates_pct
FROM
(
    SELECT
        groupArray(n_messages) as n_messages_arr,
        sum(cnt) as sum,
        arrayCumSum(groupArray(cnt)) as cnt_movsum_arr,
        arrayPopBack(arrayPushFront(arrayMap(x -> sum - x, cnt_movsum_arr), toInt64(sum))) as cnt_funnel
    FROM
        (
            SELECT n_messages,
                   sum(n_messages) as cnt
            FROM (
                  SELECT user_id,
                         length(arrayFilter(x -> x != 'terminate',
                                            arrayJoin(arraySplit(x -> x = 'terminate', groupArray(type))))) as n_messages
                  FROM (
                        SELECT user_id,
                               type
                        FROM events_parsed
                        WHERE timestamp BETWEEN startTime AND endTime
                          AND project_id = project
                          AND (type = 'terminate' OR (incoming = 1 AND meta != '{}'))
                        ORDER BY user_id, ts_ns
                           )
                  GROUP BY user_id
                  ORDER BY n_messages DESC
                     )
            WHERE n_messages > 0
            GROUP BY n_messages
            ORDER BY n_messages
    )
)
ARRAY JOIN n_messages_arr AS n_messages, cnt_funnel as cnt
;




-- top intents
WITH
    '2022-09-01 00:00:00' as startTime,
    '2022-10-01 00:00:00' as endTime,
    'prod-363' as project,
    (project_id = project
     AND (incoming = 1 AND meta != '{}')
     AND timestamp BETWEEN startTime AND endTime) as clause,
(
      SELECT count(arrayJoin(intents)) as t
      FROM events_parsed
      WHERE clause
) as total
SELECT intent,
       count(intent) as count,
       round(count / total * 100, 2) as count_pct
FROM (
      SELECT arrayJoin(intents) as intent
      FROM events_parsed
      WHERE clause
         )
GROUP BY intent
ORDER BY count DESC
;



-- coverage
WITH
    '2022-09-01 00:00:00' as startTime,
    '2022-10-01 00:00:00' as endTime,
    'prod-363' as project
SELECT
    project,
    count() as cnt,
    sum(is_a) as cov_a,
    sum(is_b) as cov_b,
    sum(is_c) as cov_c,
    cov_a + cov_b as cov,
    round(cov_a / cnt * 100, 2) as cov_a_pct,
    round(cov_b / cnt * 100, 2) as cov_b_pct,
    round(cov_c / cnt * 100, 2) as cov_c_pct,
    round(cov / cnt * 100, 2) as cov_pct
FROM (
      SELECT countIf(type = 'terminate') = 0                                   as is_a,
             countIf(fully_marked = 0) = 0 AND countIf(type = 'terminate') > 0 as is_b,
             countIf(fully_marked = 0) > 0 AND countIf(type = 'terminate') > 0 as is_c
      FROM events_parsed
      WHERE timestamp BETWEEN startTime AND endTime
        AND project_id = project
      GROUP BY user_id
)
;


-- events, user_events, lia_events, users, sessions, terminates
WITH
    '2022-09-01 00:00:00' as startTime,
    '2022-10-01 00:00:00' as endTime,
    'prod-363' as project,
    ('prod-188', 'prod-189', 'prod-363', 'prod-364') as special_projects
SELECT
       project,
       countIf(DISTINCT event_id, type = 'terminate') as terminates,
       uniqExact(event_id) as events,
       countIf(DISTINCT event_id, incoming = 1) as user_events,
       countIf(DISTINCT event_id, incoming = 0) as lia_events,
       uniqExact(visitor_id)      as v,
       uniqExact(user_id)         as sessions,
       if(v > 1 AND v <= sessions AND project NOT IN special_projects, v, sessions) as users
FROM events_parsed
WHERE
    timestamp BETWEEN startTime AND endTime
    AND project_id = project
;


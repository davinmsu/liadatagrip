SELECT
    timestamp,
    JSONExtractString(JSONExtractRaw(JSONExtractRaw(meta, 'entities'), 'phone'), 'str') as rec
FROM events_parsed
WHERE
    project_id = 'prod-131'
    AND toDate(timestamp) = today()
    AND incoming = 1
    AND rec != ''
;



-- {"intents": {"intent-24821": {"proba": 1.0000000194812826}}, "fully_marked": true, "entities": {"order_status": {"type": "keywords", "span": {"start": 7, "end": 13}, "str": "\u0441\u0442\u0430\u0442\u0443\u0441", "details": null, "raw": "\u0441\u0442\u0430\u0442\u0443\u0441", "others": [{"span": {"start": 7, "end": 20}, "str": "\u0441\u0442\u0430\u0442\u0443\u0441", "details": null, "raw": "\u0441\u0442\u0430\u0442\u0443\u0441 \u0437\u0430\u043a\u0430\u0437\u0430"}]}}, "unfiltered_intents": {"intent-24821": {"proba": 1.0000000194812826}}, "unfiltered_fullymarked": true}
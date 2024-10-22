query = """
        SELECT 
            device.deviceCategory AS device,
            COUNT(*) AS sessions,
            SUM(totals.bounces)/COUNT(*) AS exit_rate
        FROM 
            `bigquery-public-data.google_analytics_sample.ga_sessions_*`,
            UNNEST(hits) AS hits
        WHERE
            _TABLE_SUFFIX BETWEEN '20160801' AND '20170801'
        GROUP BY 
            device
        ORDER BY 
            sessions DESC
        """

result = client.query(query).result().to_dataframe()
result.head(10)
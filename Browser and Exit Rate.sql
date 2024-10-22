query = """
        SELECT 
            device.Browser AS browser,
            COUNT(*) AS sessions,
            SUM(totals.bounces)/COUNT(*) AS exit_rate
        FROM 
            `bigquery-public-data.google_analytics_sample.ga_sessions_*`,
            UNNEST(hits) AS hits
        WHERE
            _TABLE_SUFFIX BETWEEN '20160801' AND '20170801'
        GROUP BY 
            browser
        ORDER BY 
            sessions DESC
        LIMIT 10
        """

result = client.query(query).result().to_dataframe()
result.head(10)
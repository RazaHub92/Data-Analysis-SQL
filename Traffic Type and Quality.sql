query = """
        SELECT 
            trafficSource.medium AS medium,
            COUNT(*) AS sessions,
            SUM(totals.bounces)/COUNT(*) AS exit_rate,
            SUM(totals.transactions) AS transactions,
            SUM(totals.totalTransactionRevenue)/1000000 AS total_revenue,
            SUM(totals.transactions)/COUNT(*) AS conversion_rate
        FROM 
            `bigquery-public-data.google_analytics_sample.ga_sessions_*`,
            UNNEST(hits) AS hits
        WHERE
            _TABLE_SUFFIX BETWEEN '20160801' AND '20170801'
        GROUP BY
            medium
        ORDER BY
            sessions DESC
        """

result = client.query(query).result().to_dataframe()
result.head(10)
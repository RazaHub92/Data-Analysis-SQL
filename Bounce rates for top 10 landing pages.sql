query = """
        SELECT 
            hits.page.pagePath AS landing_page,
            COUNT(*) AS views,
            SUM(totals.bounces)/COUNT(*) AS bounce_rate
        FROM 
            `bigquery-public-data.google_analytics_sample.ga_sessions_*`,
            UNNEST(hits) AS hits
        WHERE
            _TABLE_SUFFIX BETWEEN '20160801' AND '20170801'
        AND
            hits.type='PAGE'
        AND
            hits.hitNumber=1
        GROUP BY
            landing_page
        ORDER BY
            views DESC
        LIMIT 10
        """

result = client.query(query).result().to_dataframe().sort_values(by='bounce_rate', axis=0)
fig, ax = plt.subplots(figsize=(10,6))
result.plot(y=['bounce_rate'], x='landing_page', kind='barh', legend=False,
            title='Bounce Rates for Top 10 Landing Pages', ax=ax)
ax.set_ylabel('')

plt.show()
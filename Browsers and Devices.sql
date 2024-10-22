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
        LIMIT 7
        """

result = client.query(query).result().to_dataframe()
fig, ax = plt.subplots(figsize=(12,7))
result.plot(y=['sessions', 'exit_rate'], x='browser', kind='bar', secondary_y='exit_rate',
            ax=ax, mark_right=False, title='Sessions and Exit Rates by Browser')

ax.set_xticklabels(labels=result['browser'], rotation=45)
ax.set_xlabel('')
ax.legend(loc=(1.1, 0.55))
plt.legend(loc=(1.1, 0.5))

plt.show()
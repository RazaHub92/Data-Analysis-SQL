query = """ 
        WITH daily_mens_tshirt_transactions AS
        (
        SELECT 
            date,
            SUM(totals.transactions) AS transactions
        FROM 
            `bigquery-public-data.google_analytics_sample.ga_sessions_*`,
            UNNEST(hits) AS hits,
            UNNEST(hits.product) AS product
        WHERE
            _TABLE_SUFFIX BETWEEN '20160801' AND '20170801'
        AND
            product.v2ProductCategory = "Home/Apparel/Men's/Men's-T-Shirts/"
        GROUP BY
            date
        ORDER BY
            date
        )
        
        SELECT
            date,
            AVG(transactions)
            OVER (
                  ORDER BY date
                  ROWS BETWEEN 3 PRECEDING AND 3 FOLLOWING    
                 ) AS avg_transactions
        FROM 
            daily_mens_tshirt_transactions
        """

result = client.query(query).result().to_dataframe()
result['date'] = pd.to_datetime(result['date'])
result.plot(y='avg_transactions', x='date', kind='line', 
            title='Men\'s T-Shirts Conversions 7-Day Moving Average', figsize=(12,6))
plt.show()
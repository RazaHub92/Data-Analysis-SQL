# Aggregate hits by action type
query = """
        SELECT 
            CASE WHEN hits.eCommerceAction.action_type = '1' THEN 'Click through of product lists'
                 WHEN hits.eCommerceAction.action_type = '2' THEN 'Product detail views'
                 WHEN hits.eCommerceAction.action_type = '5' THEN 'Check out'
                 WHEN hits.eCommerceAction.action_type = '6' THEN 'Completed purchase'
            END AS action,
            COUNT(fullVisitorID) AS users,
        FROM 
            `bigquery-public-data.google_analytics_sample.ga_sessions_*`,
            UNNEST(hits) AS hits,
            UNNEST(hits.product) AS product
        WHERE
            _TABLE_SUFFIX BETWEEN '20160801' AND '20170801'
        AND
            (
            hits.eCommerceAction.action_type != '0' 
            AND 
            hits.eCommerceAction.action_type != '3' 
            AND 
            hits.eCommerceAction.action_type != '4'
            )
        GROUP BY 
            action
        ORDER BY 
            users DESC
        """

result = client.query(query).result().to_dataframe()
result.head(10)
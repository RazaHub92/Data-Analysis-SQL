fig, ax = plt.subplots(figsize=(10,6))
cat_result.sort_values(by='total_revenue', axis=0).plot(y='total_revenue', x='category', 
                                                        kind='barh', title='Revenue by Category', ax=ax)
ax.set_ylabel('')
plt.show()

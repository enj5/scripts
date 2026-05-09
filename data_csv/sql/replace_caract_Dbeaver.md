```sql
SELECT resource_id, 
resource_name, 
REPLACE(REPLACE(REPLACE(snapshot, '\\n', '@#@'), ';', '#*#'), '\\r', '*@*') AS snapshot, 
REPLACE(REPLACE(REPLACE(changeset, '\\n', '@#@'), ';', '#*#'), '\\r', '*@*') AS changeset, 
--REPLACE(REPLACE(REPLACE(logged_at, '\\n', '@#@'), ';', '#*#'), '\\r', '*@*') AS logged_at
logged_at
FROM read_files(
  'abfss://landing@stccddatappfrc001.dfs.core.windows.net/PRISM_ENJ-NYA/bq-results-20260409-161202-1775751177573.csv',
  format => 'csv',
  header => 'true',
  sep => ',',
  quote => '"',
  escape => '"'
)
WHERE resource_name IN ('product', 'product_model') 
--LIMIT 10000
```
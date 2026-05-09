```sql
SELECT index_id, resource_id, 
resource_name, 
REPLACE(REPLACE(REPLACE(attribute_name, '@#@', '\n'), '#*#', ';'), '*@*', '\r') AS attribute_name, 
REPLACE(REPLACE(REPLACE(value_current, '@#@', '\n'), '#*#', ';'), '*@*', '\r') AS value_current, 
REPLACE(REPLACE(REPLACE(value_new, '@#@', '\n'), '#*#', ';'), '*@*', '\r') AS value_new,
REPLACE(REPLACE(REPLACE(value_old, '@#@', '\n'), '#*#', ';'), '*@*', '\r') AS value_old,
logged_at
FROM public.ressource_attribut_valeur
WHERE value_current LIKE '%\n%';
--LIMIT 10000;
```
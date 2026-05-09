 ```sql
 SELECT index_id,
    resource_id,
    resource_name,
    attribute_name,
    value_current,
    value_new,
    value_old,
    logged_at
   FROM ressource_attribut_valeur
  WHERE (attribute_name IN ( SELECT liste_axes_de_variation.code_attribut_pim
           FROM liste_axes_de_variation)) AND value_new IS NULL AND value_old IS NOT NULL;
```
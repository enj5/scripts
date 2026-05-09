 SELECT index_id,
    resource_id,
    resource_name,
    replace(replace(replace(attribute_name, '@#@'::text, '\n'::text), '#*#'::text, ';'::text), '*@*'::text, '\r'::text) AS attribute_name,
    replace(replace(replace(value_current, '@#@'::text, '\n'::text), '#*#'::text, ';'::text), '*@*'::text, '\r'::text) AS value_current,
    replace(replace(replace(value_new, '@#@'::text, '\n'::text), '#*#'::text, ';'::text), '*@*'::text, '\r'::text) AS value_new,
    replace(replace(replace(value_old, '@#@'::text, '\n'::text), '#*#'::text, ';'::text), '*@*'::text, '\r'::text) AS value_old,
    logged_at
   FROM ressource_attribut_valeur
  WHERE (attribute_name IN ( SELECT liste_axes_de_variation.code_attribut_pim
           FROM liste_axes_de_variation)) AND value_new IS NULL AND value_old IS NOT NULL;
/*Requête SQL - Jointures SKU / CODE / MESURE

Cette requête :
- récupère les attributs (non Famille) supprimés
- ajoute les colonnes `sku`, `code` et `mesure`
- nettoie les caractères spéciaux

*/
--
--
--
SELECT 
    t1.resource_id,
    t2.sku,
    t3.code,
    REPLACE(REPLACE(REPLACE(t1.Attributs, '@#@', '\n'), '#*#', ';'), '*@*', '\r') AS Attributs,
    REPLACE(REPLACE(REPLACE(t1.Valeur, '@#@', '\n'), '#*#', ';'), '*@*', '\r') AS Valeur,
    REPLACE(REPLACE(REPLACE(t1.Valeur_new, '@#@', '\n'), '#*#', ';'), '*@*', '\r') AS Valeur_new,
    REPLACE(REPLACE(REPLACE(t1.Valeur_old, '@#@', '\n'), '#*#', ';'), '*@*', '\r') AS Valeur_old,
    t4.mesure,
    t1.logged_at
FROM read_files(
    'abfss://landing@stccddatappfrc001.dfs.core.windows.net/PRISM_ENJ-NYA/attribut_valeur_py_win1252.csv',
    format  => 'csv',
    header  => 'true',
    sep     => ';',
    quote   => '"',
    escape  => '"'
) AS t1
--=======================================================================================================================
--
--                                                 Jointure pour la colonne sku
--
--=======================================================================================================================
LEFT JOIN (
    SELECT DISTINCT 
        resource_id,
        Valeur AS sku
    FROM read_files(
        'abfss://landing@stccddatappfrc001.dfs.core.windows.net/PRISM_ENJ-NYA/attribut_valeur_py_win1252.csv',
        format  => 'csv',
        header  => 'true',
        sep     => ';',
        quote   => '"',
        escape  => '"'
    )
    WHERE Attributs = 'sku'
) AS t2
ON t1.resource_id = t2.resource_id
--=======================================================================================================================
--
--                                                Jointure pour la colonne code
--
--=======================================================================================================================
LEFT JOIN (
    SELECT DISTINCT 
        resource_id,
        Valeur AS code
    FROM read_files(
        'abfss://landing@stccddatappfrc001.dfs.core.windows.net/PRISM_ENJ-NYA/attribut_valeur_py_win1252.csv',
        format  => 'csv',
        header  => 'true',
        sep     => ';',
        quote   => '"',
        escape  => '"'
    )
    WHERE Attributs = 'code'
) AS t3
ON t1.resource_id = t3.resource_id
--=======================================================================================================================
--
--                                                  Jointure pour la colonne mesure
--
--=======================================================================================================================
LEFT JOIN (
    SELECT DISTINCT resource_id,
        REGEXP_REPLACE(Attributs, '-unit$', '') AS attribute_name,
        Valeur_old AS mesure,
        logged_at
    FROM read_files(
        'abfss://landing@stccddatappfrc001.dfs.core.windows.net/PRISM_ENJ-NYA/attribut_valeur_py_win1252.csv',
        format => 'csv',
        header => 'true',
        sep => ';',
        quote => '"',
        escape => '"'
    )
    WHERE LOWER(Attributs) NOT LIKE '%famille%'
      AND LOWER(Attributs) LIKE '%unit%'
      AND Valeur_new IS NULL
      AND Valeur_old IS NOT NULL
) AS t4
ON t1.resource_id = t4.resource_id
AND t1.logged_at = t4.logged_at
AND t1.Attributs = t4.attribute_name
-----
-----
-----
-----
WHERE t1.Valeur_new IS NULL
  AND t1.Valeur_old IS NOT NULL
  AND LOWER(t1.Attributs) NOT LIKE '%famille%'

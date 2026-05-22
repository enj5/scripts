-- On veut voir si resource_id est une clé primaire. s'il y'a des doublons induit que non
-- dans le cas où on veut savoir un couple est unclé promaire on suit le même raisonnement mais on groupe sur un couple
-- si on selectionne 3 elements et qu'on veut savoir s'il existe une clé primaire on fait le groupement sur 2 et le collect_set sur un
--
--
-- Le mieux quand on fait des jointures sur la meme table de reference, c'est d'insérer une colonne id incrémenté qui sera notre clé primaire pour les jointures
-- 
SELECT 
    resource_id,
--  COUNT(DISTINCT Valeur) AS nb_sku_differents,
    COLLECT_SET(Valeur) AS code_differents,
    SIZE(COLLECT_SET(Valeur)) AS nb_codes_differents
FROM read_files(
    'abfss://landing@stccddatappfrc001.dfs.core.windows.net/PRISM_ENJ-NYA/attribut_valeur_py_win1252.csv',
    format  => 'csv',
    header  => 'true',
    sep     => ';',
    quote   => '"',
    escape  => '"'
)
WHERE Attributs = 'code'
GROUP BY resource_id
-- HAVING COUNT(DISTINCT Valeur) > 1;
HAVING SIZE(COLLECT_SET(Valeur)) > 1

SELECT *
FROM read_files(
  'abfss://landing@stccddatappfrc001.dfs.core.windows.net/PRISM_ENJ-NYA/attribut_valeur_py.csv',
  format => 'csv',
  header => 'true',
  sep => ';',
  -- Attention, plus besoin d'éviter les guillemets "
  quote => '$',
  escape => '$'
)
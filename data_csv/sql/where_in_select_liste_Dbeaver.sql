SELECT *
FROM read_files(
  'abfss://landing@stccddatappfrc001.dfs.core.windows.net/PRISM_ENJ-NYA/attribut_valeur_py.csv',
  format => 'csv',
  header => 'true',
  sep => ';',
  quote => '$',
  escape => '$'
)
WHERE Attributs IN (
	SELECT Code_ATTRIBUT_PIM
	FROM read_files(
		'abfss://landing@stccddatappfrc001.dfs.core.windows.net/PRISM_ENJ-NYA/Liste_axes_de_variation.csv',
		format => 'csv',
	  	header => 'true',
	  	sep => ';'
	)
) AND Valeur_new IS NULL AND Valeur_old IS NOT NULL
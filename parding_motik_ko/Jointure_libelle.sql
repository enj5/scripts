SELECT 
  coment.PK_NO_CONV_VBELN, 
  --coment.COMENT_Motif_KO, 
  --coment.COMENT_Valid_KO, 
  ARRAY_JOIN(COLLECT_LIST(coment.Designation), ' - ') AS Designation
FROM (
	SELECT
	  splited.PK_NO_CONV_VBELN, 
	  splited.COMENT_Motif_KO, 
	  splited.COMENT_Valid_KO,
	  splited.Position_Motif,
	  lib.Designation
	FROM (
		SELECT 
		  ce.PK_NO_CONV_VBELN, 
		  ce.COMENT_Motif_KO, 
		  ce.COMENT_Valid_KO,
		  t.pos,
		  t.lettre,
		  CASE 
			WHEN ce.COMENT_Motif_KO = '' THEN NULL 
			ELSE t.pos + 1 
		  END AS Position_Motif 
		FROM dev_1_preprod.gold.g_commandes_entete_fr AS ce
		LATERAL VIEW posexplode(split(ce.COMENT_Motif_KO, '')) t AS pos, lettre
		WHERE lettre <> '.'
	) AS splited
	LEFT JOIN (
		SELECT *
		FROM read_files(
		  'abfss://landing@stccddatappfrc001.dfs.core.windows.net/PRISM_ENJ-NYA/Libelle_Motif_KO.csv',
		  format => 'csv',
	 	  header => 'true',
	  	  sep => ';',
	  	  quote => '"',
	  	  escape => '"'
		)
	) AS lib
	  ON lib.Position_motif = splited.Position_Motif
) as coment
GROUP BY coment.PK_NO_CONV_VBELN
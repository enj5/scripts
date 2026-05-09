import pandas as pd
import os 

dossier = os.path.dirname(__file__)
cheminE = os.path.join(dossier, "entree_test.csv")
cheminS = os.path.join(dossier, "sortie_test.csv")

premier_chunk = True

for chunk in pd.read_csv(cheminE, chunksize=5):
    chunk_filtre = chunk[chunk["type"] == "product"]
    chunk_filtre.to_csv(cheminS, mode="a", header=premier_chunk, index=False)
    premier_chunk = False

import pandas as pd
import os 

dossier = os.path.dirname(__file__)
cheminE = os.path.join(dossier, "bq-results-20260409-161202-1775751177573.csv")
cheminS = os.path.join(dossier, "bq-result_filtered_py.csv")

premier_chunk = True

#i = 0
for chunk in pd.read_csv(cheminE, chunksize=10000, on_bad_lines="skip"):
    #print(f"Chunk {i} lu")
    chunk_filtre = chunk[chunk["resource_name"].isin(["product", "product_model"])]
    chunk_filtre.to_csv(cheminS, mode="a", header=premier_chunk, sep = ";", index=False)
    #print(f"Chunk {i} écrit")
    premier_chunk = False
    #i += 1
    


"""for i, chunk in enumerate(pd.read_csv(cheminE, chunksize=10000, on_bad_lines="skip")):
    if i == 8:
        print(chunk.head())
        print(chunk.shape)
        break"""

print(f"{error} lignes ignorées!!!")
import os 
import pandas as pd


dossier = os.path.dirname(__file__)
cheminE = os.path.join(dossier, "bq-results-20260409-161202-1775751177573.csv")
cheminS = os.path.join(dossier, "bq-filter_product.csv")
"""
with open(cheminS) as file:
    cmp = 0
    for line in file:
        cmp += 1
    
    print("Nombre de lignes = %d" % cmp - 1)
"""
lines = pd.read_csv(cheminS)
print(len(lines))

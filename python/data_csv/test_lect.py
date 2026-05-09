import os

dossier = os.path.dirname(__file__)


chemin = os.path.join(dossier, "bq-results-20260409-161202-1775751177573.csv")

with open(chemin, encoding="utf-8") as file:
    
    table = list()
    for l in file:
        table.append(l)
    
    table2 = table[1].split(",")
    print(table[1])
    print(len(table2))
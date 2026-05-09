import os
import pandas as pd 
import json

dossier = os.path.dirname(__file__)
cheminE = os.path.join(dossier, "bq-filter_product.csv")
cheminS = os.path.join(dossier, "snapshot.csv")

with open(cheminS, "w+", encoding="utf-8") as file:
    #file.write("Attributs,Valeur")
    error = 0
    set_cle = set()

    # Premiere pass du fichier
    for chunk in pd.read_csv(cheminE, chunksize=10000, on_bad_lines="skip", dtype=str, encoding="utf-8", low_memory=False):
        for elts in chunk["snapshot"]:
            try:
                dico = json.loads(elts)
                for k in dico:
                    set_cle.add(k)
            except:
                error += 1
  
    # Ecriture dans le fichier
    setToString = ",".join(list(sorted(set_cle)))
    file.write(setToString)
    print(len(set_cle))
    for s in sorted(set_cle):
        print(s)
    print(f"{error} cellules ignorées!!!")
"""
    error = 0
    nb = 0
    # Deuxieme pass du fichier
    for chunk in pd.read_csv(cheminE, chunksize=500, on_bad_lines="skip", dtype=str, encoding="utf-8", low_memory=False):
        
        for elts in chunk["snapshot"]:
            if nb == 3:
                break
            list_valeur = list()
            try:
                dico = json.loads(elts)
                for key in set_cle:
                    if key in dico:
                        list_valeur.append(str(dico[key]))
                    else:
                        list_valeur.append("null")
            except:
                error += 1
            # Ecriture dans le fichier
            listToString = ",".join(list_valeur)
            file.write(listToString + "\n")
            nb += 1
    print(f"{error} cellules ignorées!!!")
    """
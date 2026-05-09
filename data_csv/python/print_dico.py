import os
import pandas as pd 
import json

dossier = os.path.dirname(__file__)
cheminE = os.path.join(dossier, "bq-result_filtered_py.csv")
cheminS1 = os.path.join(dossier, "print_snapchot_dico.csv")
cheminS2 = os.path.join(dossier, "print_changeset_dico.csv")



#file.write("Attributs,Valeur")
"""
error = 0
set_cle = set()

# Premiere pass du fichier - Récupération des clés du dico
for chunk in pd.read_csv(cheminE, chunksize=10000, on_bad_lines="skip", dtype=str, encoding="utf-8", low_memory=False):
    for elts in chunk["snapshot"]:
        try:
            dico = json.loads(elts)
            for k in dico:
                set_cle.add(k)
        except:
            error += 1

print(f"{error} cellules ignorées!!!")
"""
# ------
with open(cheminS1, "w+", encoding="utf-8") as file1:
    with open(cheminS2, "w+", encoding="utf-8") as file2:
        file1.write("Attributs;Valeur\n")
        file2.write("Attributs;Valeur_new;Valeur_old\n")
    
    error = 0
    
    # Deuxième pass du fichier
    for chunk in pd.read_csv(cheminE, chunksize=10000, delimiter =";", on_bad_lines="skip", dtype=str, encoding="utf-8", low_memory=False):
        for r_id,snapshot,changeset,logged in zip(chunk["resource_id"],chunk["snapshot"],chunk["changeset"],chunk["logged_at"]):
            try:
                dico_snap = json.loads(snapshot)
                dico_change = json.loads(changeset)  
                for k,v in dico_snap.items():
                    file1.write(f"{k};{v}\n")
                for k,v in dico_change.items():
                    file2.write(f"{k};{dico_change[k]["new"]};{dico_change[k]["old"]}\n") 
            except:
                error += 1
    
    
  
    # Ecriture dans le fichier
    """setToString = ",".join(list(sorted(set_cle)))
    file.write(setToString)
    print(len(set_cle))
    for s in sorted(set_cle):
        print(s)"""
    print(f"{error} cellules ignorées!!!")
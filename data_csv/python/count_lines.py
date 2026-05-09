import os 

dossier = os.path.dirname(__file__)
#cheminE = os.path.join(dossier, "entree_test.csv")
cheminS = os.path.join(dossier, "sortie_test.csv")

with open(cheminS) as file:
    cmp = 0
    for line in file:
        cmp += 1
    
    print("Nombre de lignes = %d" % cmp)
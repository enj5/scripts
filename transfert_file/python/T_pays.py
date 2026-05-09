### Objectif : Tranférer un fichier d'un dossier à un autre

import shutil # Shell Utilities : boîte à outil 
              # pour manipuler des fichiers

import os     # avec la méthode rmdir() pour supprimer un dossier vide

#Base du chemin d'accès
che_base = "C:/Users/E_NJINKOUE/Documents/Alternance_ESGI-GACD/2026/" \
           "Tâches_diverses/PRISM - AKNEO/OneDrive_1_12-03-2026/EREF_PAYS"

dest = f"{che_base}/Image/" #chemin de destination

for c1 in range(ord('A'), ord('Z')+1):      #Conversion au code ASCII décimal
    i = chr(c1)                             #Conversion en char(caractère)
    for c2 in range(ord('A'), ord('Z')+1):
        j = chr(c2)
        src = f"{che_base}/files/AA/image/Drapeau_AA.svg/Drapeau_{i}{j}.svg" #chemin source
        
        try:                        #Test si le chemin d'accès existe
            shutil.move(src, dest)  #copier-coller de la source à la destination
        except:                     #S'il n'existe pas il ignore
            pass

#os.rmdir("{che_base}/files/AA/image/Drapeau_AA.svg") #censer supprimer le dossier 
                                                    # Drapeau_AA.svg?? N'a pas fonctionné

# src = f"{che_base}/files/AG/image/Drapeau_AG.svg"
# dest = f"{che_base}/Image/"

# shutil.move(src, dest)

# import os
# print(os.path.exists(src))  # affiche True si il trouve le fichier ou False sinon
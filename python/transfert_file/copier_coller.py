### Objectif : Tranférer un fichier d'un dossier à un autre

import shutil # Shell Utilities : boîte à outil 
              # pour manipuler des fichiers

import os     # pour manipuler des dossiers


''' 
Fonction qui copie un fichier dans différents dossiers 
puis colle les différents fichiers dans un même dossier
'''

def copier_coller(ch_dep, ch_arr) : 
    dest = ch_arr # Destination
    for dossier, sous_dossiers, fichiers in os.walk(ch_dep): # Parcours de chaque dossier
        for fichier in fichiers:                    # Parcours de chaque fichiers
            src = os.path.join(dossier, fichier)    # Source : Jointure des chemins d'accès
            shutil.move(src, dest)                  # copier-coller


# Chemin d'accès commun à tous les autres
ch_base = "C:/Users/E_NJINKOUE/Documents/Alternance_ESGI-GACD/2026/" \
        "Tâches_diverses/PRISM - AKNEO/OneDrive_1_12-03-2026/EREF_PAYS"  

ch_dep = f"{ch_base}/files"     # Chemin d'accès d'origine des fichiers

ch_arr = f"{ch_base}/Image/"    # Chemin d'accès d'arrivé


copier_coller(ch_dep, ch_arr)   # Appel du copier-coller
        





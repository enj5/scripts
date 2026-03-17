### Objectif : Tranférer un fichier d'un dossier à un autre

import shutil # Shell Utilities : boîte à outil 
              # pour manipuler des fichiers

ch_base = ("C:/Users/E_NJINKOUE/Documents/Alternance_ESGI-GACD/2026/"
        "Tâches_diverses/PRISM - AKNEO/OneDrive_1_12-03-2026/EREF_FORMAT_PAPIER/files")
for i in range(0, 11):
    for j in "ABC":
        src = f"{ch_base}/{j}{i}/image/{j}{i}.png" # chemin de la source
        dest = f"{ch_base}/Image/" # chemin de la destination
        shutil.move(src, dest) # copier-coller de la source à la destination




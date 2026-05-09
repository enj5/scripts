import os

dossier = os.path.dirname(__file__)
cheminE = os.path.join(dossier, "attribut_valeur_py.csv")
cheminS = os.path.join(dossier, "attribut_valeur_py_cleanPY.csv")


with open(cheminE, 'rb') as f_in:
    with open(cheminS, 'wb') as f_out:
        for chunk in iter(lambda: f_in.read(1024*1024), b''):
            clean = bytes(b for b in chunk if b not in (0x81, 0x8d, 0x8f, 0x90, 0x9d))
            f_out.write(clean)
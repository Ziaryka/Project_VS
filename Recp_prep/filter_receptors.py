import pandas as pd

pd.set_option('display.max_columns', None)  # Afficher toutes les colonnes
pd.set_option('display.max_rows', None)  # Afficher toutes les lignes
pd.set_option('expand_frame_repr', False)  # Pas de saut de ligne
url = 'https://www.uniprot.org/uniprot/Q07817#structure'
df = pd.read_html(url)[-16]
# print(df[(df["Durée (mois)"] == "6 mois") & (df["Ville"] == "Paris")])
df = df.rename(columns=df.iloc[0, :])
df = df.iloc[1:, 1:]
Xray = df[df.Method == "X-ray"]
NMR = df[df.Method == "NMR"]

Xray["Resolution (Å)"] = pd.to_numeric(Xray["Resolution (Å)"])
# Xray[['start', 'end']] = Xray['Positions'].str.split('-', expand=True)
# Xray.start = pd.to_numeric(Xray.start)
# Xray.end = pd.to_numeric(Xray.end)

# Xray["length"] = Xray.end - Xray.start
NMR_good = NMR[NMR.Positions == "1-209"].reset_index()
# print(Xray[(Xray["Resolution (Å)"] < 2.7) & (df["length"] > 200)])
Xray_good = Xray[(Xray["Resolution (Å)"] < 2.5) & (df["Positions"] == "1-209")].reset_index()
# print(Xray[(Xray["Resolution (Å)"] < 2.7)])
# print(NMR_good)
# print(Xray_good)

apo = "1lxl 1maz 1r2d 1r2e 1r2i 2lpc 2me8 2me9 3cva 6bf2 7ca4".upper().split(" ")
NMR_good_list = list(NMR_good["PDB entry"])
Xray_good_list = list(Xray_good["PDB entry"])
all = NMR_good_list + Xray_good_list
holo = list(set(all) - set(apo))
print(len(holo))

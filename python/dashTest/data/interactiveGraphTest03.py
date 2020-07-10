from pyvis.network import Network
import dash
import dash_html_components as html
import dash_core_components as dcc
from dash.dependencies import Input, Output
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
import networkx as nx
import plotly.express as px
import plotly.graph_objects as go
import seaborn as sns
from plotly.subplots import make_subplots
import matplotlib.cm as cm
from scipy.stats import wasserstein_distance, energy_distance
import matplotlib
import statistics as st
import plotly.figure_factory as ff
from tqdm import trange
from tqdm import tqdm
import os.path
from pathlib import Path
import operator
from pyvis.network import Network

path = Path(__file__).parent / "\\OVGU\\WiSe19_20\\VA project\\GitHub\\" \
                               "Visuaization_2019-20\\python\\dashTest\\data\\networkQ1\\"
pathCSV = str(path) + "\\dfSeed1_Lvl2.csv"
dfSeed1_Lvl2 = pd.read_csv(pathCSV)
pathCSV = str(path) + "\\DemographicCategories.csv"
dfCategory = pd.read_csv(pathCSV)
pathCSV = str(path) + "\\dfSeed1_Lvl1.csv"
dfSeed1_Lvl1 = pd.read_csv(pathCSV)
pathCSV = str(path) + "\\Seed1-Graph2Com.csv"
dfSeed1Com = pd.read_csv(pathCSV)
pathCSV = str(path) + "\\Seed1-Graph2NonCom.csv"
dfSeed1NonCom = pd.read_csv(pathCSV)
pathCSV = str(path) + "\\Seed3-Graph2Com.csv"
dfSeed3Com = pd.read_csv(pathCSV)
pathCSV = str(path) + "\\Seed3-Graph2NonCom.csv"
dfSeed3NonCom = pd.read_csv(pathCSV)

dfSeed1_Lvl2 = dfSeed1Com.append(dfSeed1NonCom)

dfSeed1_Lvl2G = nx.MultiDiGraph()
dfSeed1_Lvl2Tuple = [tuple([x, y]) for x, y in zip(dfSeed1_Lvl2["Source"], dfSeed1_Lvl2["Target"])]
dfSeed1_Lvl2G.add_edges_from(dfSeed1_Lvl2Tuple)
print()

people = list()

people = people + list(dict.fromkeys(list(dfSeed1_Lvl2[dfSeed1_Lvl2["eType"] != 5]["Source"]) +
                                     list(dfSeed1_Lvl2[dfSeed1_Lvl2["eType"] <= 1]["Target"])))

for node in tqdm(list(dict.fromkeys(list(dfSeed1_Lvl2[dfSeed1_Lvl2["eType"] == 5]["Source"]) +
                                    list(dfSeed1_Lvl2[dfSeed1_Lvl2["eType"] == 5]["Target"])))):

  if node not in list(dfCategory["NodeID"]):

        people = people + list([node])

items = [item for item in list(dict.fromkeys(list(dfSeed1_Lvl2["Source"]) + list(dfSeed1_Lvl2["Target"]))) if item not in people]

# fig = plt.figure(figsize=(15, 15))
# pos = nx.kamada_kawai_layout(dfSeed1_Lvl2G) # positions for all nodes

# # nodes
# nx.draw_networkx_nodes(dfSeed1_Lvl2G, pos,
#                        nodelist=people,
#                        node_color='#FF9800',
#                        node_size=500,
#                    alpha=0.8)
# nx.draw_networkx_nodes(dfSeed1_Lvl2G, pos,
#                        nodelist=items,
#                        node_color='b',
#                        node_size=500,
#                    alpha=0.8)
# nx.draw_networkx_nodes(dfSeed1_Lvl2G, pos,
#                        nodelist=list(dfSeed1_Lvl1["Source"]) + list(dfSeed1_Lvl1["Target"]),
#                        node_color='r',
#                        node_size=10000,
#                    alpha=0.8)
#
# # edges
# # nx.draw_networkx_edges(dfSeed1_Lvl2G,pos,width=1.0,alpha=0.5)
# # nx.draw_networkx_edges(dfSeed1_Lvl2G,pos,
# #                        edgelist=graph2NodesTuple,
# #                        width=2,alpha=0.5,edge_color='k')
# nx.draw_networkx_edges(dfSeed1_Lvl2G,pos,
#                        edgelist=dfSeed1_Lvl2Tuple,
#                        width=4.2,alpha=0.5,edge_color='#8C8C8C')
# fig.show()
#
# # nx_graph = dfSeed1_Lvl2G
# nt = Network("800px", "800px")
# # populates the nodes and edges data structures
# nt.from_nx(dfSeed1_Lvl2G)
# # nt.show("nx.html")
# nt.show(name="sth.html")
#

g = Network(height="1000px", width="1500px", notebook=True)
g.toggle_hide_edges_on_drag(False)
g.barnes_hut()
g.from_nx(dfSeed1_Lvl2G)
g.show("Seed1Extended.html")

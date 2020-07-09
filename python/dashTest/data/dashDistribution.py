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

app = dash.Dash(__name__)

# ------------------------------------------------------------------------------
# Import and clean data (importing csv into pandas)
path = Path(__file__).parent / "\\OVGU\\WiSe19_20\\VA project\\GitHub\\Visuaization_2019-20\\python\\dashTest\\data"
pathCSV = str(path) + "\\CGCS-Template.csv"
dfTemplate = pd.read_csv(pathCSV)
# dfTemplate = pd.read_csv("CGCS-Template.csv")
pathCSV = str(path) + "\\Q1-Graph1.csv"
dfGraph1 = pd.read_csv(pathCSV)
pathCSV = str(path) + "\\Q1-Graph2.csv"
dfGraph2 = pd.read_csv(pathCSV)
pathCSV = str(path) + "\\Q1-Graph3.csv"
dfGraph3 = pd.read_csv(pathCSV)
pathCSV = str(path) + "\\Q1-Graph4.csv"
dfGraph4 = pd.read_csv(pathCSV)
pathCSV = str(path) + "\\Q1-Graph5.csv"
dfGraph5 = pd.read_csv(pathCSV)
pathCSV = str(path) + "\\dfSeed1Reduced.csv"
dfQ2Seed1 = pd.read_csv(pathCSV)
pathCSV = str(path) + "\\dfSeed3Reduced.csv"
dfQ2Seed3 = pd.read_csv(pathCSV)
pathCSV = str(path) + "\\dfProcSeed1-Graph2ReducedFinal.csv"
dfQ3Seed1 = pd.read_csv(pathCSV)
pathCSV = str(path) + "\\dfProcSeed3-Graph2ReducedFinal.csv"
dfQ3Seed3 = pd.read_csv(pathCSV)

#Calculating the measures
# Creating empty Multi-way Directed graphs(repeated edges are considered) for each of the graphs
templateG = nx.MultiDiGraph()
graph1G = nx.MultiDiGraph()
graph2G = nx.MultiDiGraph()
graph3G = nx.MultiDiGraph()
graph4G = nx.MultiDiGraph()
graph5G = nx.MultiDiGraph()
q2seed1G = nx.MultiDiGraph()
q2seed3G = nx.MultiDiGraph()
q3seed1G = nx.MultiDiGraph()
q3seed3G = nx.MultiDiGraph()
# Putting the Source and Target values in tuples for each corresponding graph All channels
# for adding the edges into the graphs we first need to create a list of tuples of those edges
templateNodesTuple = [tuple([x, y]) for x, y in zip(dfTemplate["Source"], dfTemplate["Target"])]
graph1NodesTuple = [tuple([x, y]) for x, y in zip(dfGraph1["Source"], dfGraph1["Target"])]
graph2NodesTuple = [tuple([x, y]) for x, y in zip(dfGraph2["Source"], dfGraph2["Target"])]
graph3NodesTuple = [tuple([x, y]) for x, y in zip(dfGraph3["Source"], dfGraph3["Target"])]
graph4NodesTuple = [tuple([x, y]) for x, y in zip(dfGraph4["Source"], dfGraph4["Target"])]
graph5NodesTuple = [tuple([x, y]) for x, y in zip(dfGraph5["Source"], dfGraph5["Target"])]
q2seed1NodesTuple = [tuple([x, y]) for x, y in zip(dfQ2Seed1["Source"], dfQ2Seed1["Target"])]
q2seed3NodesTuple = [tuple([x, y]) for x, y in zip(dfQ2Seed3["Source"], dfQ2Seed3["Target"])]
q3seed1NodesTuple = [tuple([x, y]) for x, y in zip(dfQ3Seed1["Source"], dfQ3Seed1["Target"])]
q3seed3NodesTuple = [tuple([x, y]) for x, y in zip(dfQ3Seed3["Source"], dfQ3Seed3["Target"])]
# Creating graph objects from the tuples
templateG.add_edges_from(templateNodesTuple)
graph1G.add_edges_from(graph1NodesTuple)
graph2G.add_edges_from(graph2NodesTuple)
graph3G.add_edges_from(graph3NodesTuple)
graph4G.add_edges_from(graph4NodesTuple)
graph5G.add_edges_from(graph5NodesTuple)
q2seed1G.add_edges_from(q2seed1NodesTuple)
q2seed3G.add_edges_from(q2seed3NodesTuple)
q3seed1G.add_edges_from(q3seed1NodesTuple)
q3seed3G.add_edges_from(q3seed3NodesTuple)
# print("")

degreeTemplate = nx.degree(templateG)
degreeGraph1 = nx.degree(graph1G)
degreeGraph2 = nx.degree(graph2G)
degreeGraph3 = nx.degree(graph3G)
degreeGraph4 = nx.degree(graph4G)
degreeGraph5 = nx.degree(graph5G)
degreeQ2Seed1 = nx.degree(q2seed1G)
degreeQ2Seed3 = nx.degree(q2seed3G)
degreeQ3Seed1 = nx.degree(q3seed1G)
degreeQ3Seed3 = nx.degree(q3seed3G)
measure = "Degree"



degreeTemplate = templateG.out_degree()
degreeGraph1 = graph1G.out_degree()
degreeGraph2 = graph2G.out_degree()
degreeGraph3 = graph3G.out_degree()
degreeGraph4 = graph4G.out_degree()
degreeGraph5 = graph5G.out_degree()
degreeQ2Seed1 = q2seed1G.out_degree()
degreeQ2Seed3 = q2seed3G.out_degree()
degreeQ3Seed1 = q3seed1G.out_degree()
degreeQ3Seed3 = q3seed3G.out_degree()
measure = "Out-Degree"

degreeTemplate = nx.closeness_centrality(templateG)
degreeGraph1 = nx.closeness_centrality(graph1G)
degreeGraph2 = nx.closeness_centrality(graph2G)
degreeGraph3 = nx.closeness_centrality(graph3G)
degreeGraph4 = nx.closeness_centrality(graph4G)
degreeGraph5 = nx.closeness_centrality(graph5G)
degreeQ2Seed1 = nx.closeness_centrality(q2seed1G)
degreeQ2Seed3 = nx.closeness_centrality(q2seed3G)
degreeQ3Seed1 = nx.closeness_centrality(q3seed1G)
degreeQ3Seed3 = nx.closeness_centrality(q3seed3G)
measure = "Closeness_Centrality"


degreeTemplate = nx.average_neighbor_degree(templateG)
degreeGraph1 = nx.average_neighbor_degree(graph1G)
degreeGraph2 = nx.average_neighbor_degree(graph2G)
degreeGraph3 = nx.average_neighbor_degree(graph3G)
degreeGraph4 = nx.average_neighbor_degree(graph4G)
degreeGraph5 = nx.average_neighbor_degree(graph5G)
degreeQ2Seed1 = nx.average_neighbor_degree(q2seed1G)
degreeQ2Seed3 = nx.average_neighbor_degree(q2seed3G)
degreeQ3Seed1 = nx.average_neighbor_degree(q3seed1G)
degreeQ3Seed3 = nx.average_neighbor_degree(q3seed3G)
measure = "Average_Neighbor_Degree"

degreeTemplate = nx.k_nearest_neighbors(templateG)
degreeGraph1 = nx.k_nearest_neighbors(graph1G)
degreeGraph2 = nx.k_nearest_neighbors(graph2G)
degreeGraph3 = nx.k_nearest_neighbors(graph3G)
degreeGraph4 = nx.k_nearest_neighbors(graph4G)
degreeGraph5 = nx.k_nearest_neighbors(graph5G)
degreeQ2Seed1 = nx.k_nearest_neighbors(q2seed1G)
degreeQ2Seed3 = nx.k_nearest_neighbors(q2seed3G)
degreeQ3Seed1 = nx.k_nearest_neighbors(q3seed1G)
degreeQ3Seed3 = nx.k_nearest_neighbors(q3seed3G)
measure = "KNN"

# Creating empty Directed graphs for each of the graphs
templateG = nx.DiGraph()
graph1G = nx.DiGraph()
graph2G = nx.DiGraph()
graph3G = nx.DiGraph()
graph4G = nx.DiGraph()
graph5G = nx.DiGraph()
seed1G = nx.DiGraph()
seed2G = nx.DiGraph()
seed3G = nx.DiGraph()
q2seed1G = nx.DiGraph()
q2seed3G = nx.DiGraph()
q3seed1G = nx.DiGraph()
q3seed3G = nx.DiGraph()

# Putting the Source and Target values in tuples for each corresponding graph All channels
# for adding the edges into the graphs we first need to create a list of tuples of those edges
templateNodesTuple = [tuple([x, y]) for x, y in zip(dfTemplate["Source"], dfTemplate["Target"])]
graph1NodesTuple = [tuple([x, y]) for x, y in zip(dfGraph1["Source"], dfGraph1["Target"])]
graph2NodesTuple = [tuple([x, y]) for x, y in zip(dfGraph2["Source"], dfGraph2["Target"])]
graph3NodesTuple = [tuple([x, y]) for x, y in zip(dfGraph3["Source"], dfGraph3["Target"])]
graph4NodesTuple = [tuple([x, y]) for x, y in zip(dfGraph4["Source"], dfGraph4["Target"])]
graph5NodesTuple = [tuple([x, y]) for x, y in zip(dfGraph5["Source"], dfGraph5["Target"])]
q2seed1NodesTuple = [tuple([x, y]) for x, y in zip(dfQ2Seed1["Source"], dfQ2Seed1["Target"])]
q2seed3NodesTuple = [tuple([x, y]) for x, y in zip(dfQ2Seed3["Source"], dfQ2Seed3["Target"])]
q3seed1NodesTuple = [tuple([x, y]) for x, y in zip(dfQ3Seed1["Source"], dfQ3Seed1["Target"])]
q3seed3NodesTuple = [tuple([x, y]) for x, y in zip(dfQ3Seed3["Source"], dfQ3Seed3["Target"])]
# Creating graph objects from the tuples
templateG.add_edges_from(templateNodesTuple)
graph1G.add_edges_from(graph1NodesTuple)
graph2G.add_edges_from(graph2NodesTuple)
graph3G.add_edges_from(graph3NodesTuple)
graph4G.add_edges_from(graph4NodesTuple)
graph5G.add_edges_from(graph5NodesTuple)
q2seed1G.add_edges_from(q2seed1NodesTuple)
q2seed3G.add_edges_from(q2seed3NodesTuple)
q3seed1G.add_edges_from(q3seed1NodesTuple)
q3seed3G.add_edges_from(q3seed3NodesTuple)
# print("")


degreeTemplate = nx.betweenness_centrality(templateG, normalized=False)
degreeGraph1 = nx.betweenness_centrality(graph1G, normalized=False)
degreeGraph2 = nx.betweenness_centrality(graph2G, normalized=False)
degreeGraph3 = nx.betweenness_centrality(graph3G, normalized=False)
degreeGraph4 = nx.betweenness_centrality(graph4G, normalized=False)
degreeGraph5 = nx.betweenness_centrality(graph5G, normalized=False)
degreeQ2Seed1 = nx.betweenness_centrality(q2seed1G, normalized=False)
degreeQ2Seed3 = nx.betweenness_centrality(q2seed3G, normalized=False)
degreeQ3Seed1 = nx.betweenness_centrality(q3seed1G, normalized=False)
degreeQ3Seed3 = nx.betweenness_centrality(q3seed3G, normalized=False)
measure = "Betweenness_Centrality"


degreeTemplate = nx.eigenvector_centrality(templateG)
degreeGraph1 = nx.eigenvector_centrality(graph1G)
degreeGraph2 = nx.eigenvector_centrality(graph2G)
degreeGraph3 = nx.eigenvector_centrality(graph3G)
degreeGraph4 = nx.eigenvector_centrality(graph4G)
degreeGraph5 = nx.eigenvector_centrality(graph5G)
degreeQ2Seed1 = nx.eigenvector_centrality(q2seed1G)
degreeQ2Seed3 = nx.eigenvector_centrality(q2seed3G)
degreeQ3Seed1 = nx.eigenvector_centrality(q3seed1G)
degreeQ3Seed3 = nx.eigenvector_centrality(q3seed3G)
measure = "Eigenvector_Centrality"


degreeTemplate = nx.pagerank(templateG)
degreeGraph1 = nx.pagerank(graph1G)
degreeGraph2 = nx.pagerank(graph2G)
degreeGraph3 = nx.pagerank(graph3G)
degreeGraph4 = nx.pagerank(graph4G)
degreeGraph5 = nx.pagerank(graph5G)
degreeQ2Seed1 = nx.pagerank(q2seed1G)
degreeQ2Seed3 = nx.pagerank(q2seed3G)
degreeQ3Seed1 = nx.pagerank(q3seed1G)
degreeQ3Seed3 = nx.pagerank(q3seed3G)
measure = "PageRank"


# ------------------------------------------------------------------------------
# App layout
app.layout = html.Div([

    html.H1("Distribution Curve Comparisons", style={'text-align': 'center'}),

    dcc.Dropdown(id="slct_measure",
                 options=[
                     {"label": "Default", "value": "test"},
                     {"label": "Betweeenness centrality", "value": "betweenness"},
                     {"label": "Eigenvector centrality", "value": "eigenvector"},
                     {"label": "Out-Degree", "value": "out_degree"},
                     {"label": "Template vs Q1 Graph4", "value": "q1graph4"},
                     {"label": "Template vs Q1 Graph5", "value": "q1graph5"},
                     {"label": "Template vs Q2 Graph1", "value": "q2graph1"},
                     {"label": "Template vs Q2 Graph3", "value": "q2graph3"},
                     {"label": "Template vs Q3 Graph1", "value": "q3graph1"},
                     {"label": "Template vs Q3 Graph2", "value": "q3graph2"}],
                 multi=False,
                 value="betweenness",
                 style={'width': "40%"}
                 ),

    html.Div(id='output_container', children=[]),
    html.Br(),
    html.Div([
        dcc.Graph(id='distribution_graph', figure={}, config={'displayModeBar': True}),
    ], style={'width': '98%', 'display': 'inline-block', 'padding': '0 20'})
])


# ------------------------------------------------------------------------------
# Connect the Plotly graphs with Dash Components
@app.callback(
    [Output(component_id='output_container', component_property='children'),
     Output(component_id='distribution_graph', component_property='figure')],
    [Input(component_id='slct_measure', component_property='value')]
)
def update_graph(option_slctd):
    print(option_slctd)
    print(type(option_slctd))

    # container = "The option chosen by user was: {}".format(str(option_slctd))

    if option_slctd in ["betweenness", "eigenvector"]:
        # Creating empty Directed graphs for each of the graphs
        templateG = nx.DiGraph()
        graph1G = nx.DiGraph()
        graph2G = nx.DiGraph()
        graph3G = nx.DiGraph()
        graph4G = nx.DiGraph()
        graph5G = nx.DiGraph()
        q2seed1G = nx.DiGraph()
        q2seed3G = nx.DiGraph()
        q3seed1G = nx.DiGraph()
        q3seed3G = nx.DiGraph()

        # Putting the Source and Target values in tuples for each corresponding graph All channels
        # for adding the edges into the graphs we first need to create a list of tuples of those edges
        templateNodesTuple = [tuple([x, y]) for x, y in zip(dfTemplate["Source"], dfTemplate["Target"])]
        graph1NodesTuple = [tuple([x, y]) for x, y in zip(dfGraph1["Source"], dfGraph1["Target"])]
        graph2NodesTuple = [tuple([x, y]) for x, y in zip(dfGraph2["Source"], dfGraph2["Target"])]
        graph3NodesTuple = [tuple([x, y]) for x, y in zip(dfGraph3["Source"], dfGraph3["Target"])]
        graph4NodesTuple = [tuple([x, y]) for x, y in zip(dfGraph4["Source"], dfGraph4["Target"])]
        graph5NodesTuple = [tuple([x, y]) for x, y in zip(dfGraph5["Source"], dfGraph5["Target"])]
        q2seed1NodesTuple = [tuple([x, y]) for x, y in zip(dfQ2Seed1["Source"], dfQ2Seed1["Target"])]
        q2seed3NodesTuple = [tuple([x, y]) for x, y in zip(dfQ2Seed3["Source"], dfQ2Seed3["Target"])]
        q3seed1NodesTuple = [tuple([x, y]) for x, y in zip(dfQ3Seed1["Source"], dfQ3Seed1["Target"])]
        q3seed3NodesTuple = [tuple([x, y]) for x, y in zip(dfQ3Seed3["Source"], dfQ3Seed3["Target"])]

    else:
        # Calculating the measures
        # Creating empty Multi-way Directed graphs(repeated edges are considered) for each of the graphs
        templateG = nx.MultiDiGraph()
        graph1G = nx.MultiDiGraph()
        graph2G = nx.MultiDiGraph()
        graph3G = nx.MultiDiGraph()
        graph4G = nx.MultiDiGraph()
        graph5G = nx.MultiDiGraph()
        q2seed1G = nx.MultiDiGraph()
        q2seed3G = nx.MultiDiGraph()
        q3seed1G = nx.MultiDiGraph()
        q3seed3G = nx.MultiDiGraph()
        # Putting the Source and Target values in tuples for each corresponding graph All channels
        # for adding the edges into the graphs we first need to create a list of tuples of those edges
        templateNodesTuple = [tuple([x, y]) for x, y in zip(dfTemplate["Source"], dfTemplate["Target"])]
        graph1NodesTuple = [tuple([x, y]) for x, y in zip(dfGraph1["Source"], dfGraph1["Target"])]
        graph2NodesTuple = [tuple([x, y]) for x, y in zip(dfGraph2["Source"], dfGraph2["Target"])]
        graph3NodesTuple = [tuple([x, y]) for x, y in zip(dfGraph3["Source"], dfGraph3["Target"])]
        graph4NodesTuple = [tuple([x, y]) for x, y in zip(dfGraph4["Source"], dfGraph4["Target"])]
        graph5NodesTuple = [tuple([x, y]) for x, y in zip(dfGraph5["Source"], dfGraph5["Target"])]
        q2seed1NodesTuple = [tuple([x, y]) for x, y in zip(dfQ2Seed1["Source"], dfQ2Seed1["Target"])]
        q2seed3NodesTuple = [tuple([x, y]) for x, y in zip(dfQ2Seed3["Source"], dfQ2Seed3["Target"])]
        q3seed1NodesTuple = [tuple([x, y]) for x, y in zip(dfQ3Seed1["Source"], dfQ3Seed1["Target"])]
        q3seed3NodesTuple = [tuple([x, y]) for x, y in zip(dfQ3Seed3["Source"], dfQ3Seed3["Target"])]

    degreeTemplate = templateG.out_degree()
    degreeGraph1 = graph1G.out_degree()
    degreeGraph2 = graph2G.out_degree()
    degreeGraph3 = graph3G.out_degree()
    degreeGraph4 = graph4G.out_degree()
    degreeGraph5 = graph5G.out_degree()
    degreeQ2Seed1 = q2seed1G.out_degree()
    degreeQ2Seed3 = q2seed3G.out_degree()
    degreeQ3Seed1 = q3seed1G.out_degree()
    degreeQ3Seed3 = q3seed3G.out_degree()
    measure = "Out-Degree"

    # Add histogram data
    df = pd.DataFrame(list(zip([y for x, y in degreeTemplate], [x for x, y in degreeTemplate])))
    x1 = df[0]

    df = pd.DataFrame(list(zip([y for x, y in degreeGraph1], [x for x, y in degreeGraph1])))
    x2 = df[0]

    df = pd.DataFrame(list(zip([y for x, y in degreeGraph2], [x for x, y in degreeGraph2])))
    x3 = df[0]

    df = pd.DataFrame(list(zip([y for x, y in degreeGraph3], [x for x, y in degreeGraph3])))
    x4 = df[0]

    df = pd.DataFrame(list(zip([y for x, y in degreeGraph4], [x for x, y in degreeGraph4])))
    x5 = df[0]

    df = pd.DataFrame(list(zip([y for x, y in degreeGraph5], [x for x, y in degreeGraph5])))
    x6 = df[0]

    df = pd.DataFrame(list(zip([y for x, y in degreeQ2Seed1], [x for x, y in degreeQ2Seed1])))
    x7 = df[0]

    df = pd.DataFrame(list(zip([y for x, y in degreeQ2Seed3], [x for x, y in degreeQ2Seed3])))
    x8 = df[0]

    df = pd.DataFrame(list(zip([y for x, y in degreeQ3Seed1], [x for x, y in degreeQ3Seed1])))
    x9 = df[0]

    df = pd.DataFrame(list(zip([y for x, y in degreeQ3Seed3], [x for x, y in degreeQ3Seed3])))
    x10 = df[0]


    if option_slctd == "betweenness":
        degreeTemplate = nx.betweenness_centrality(templateG, normalized=False)
        degreeGraph1 = nx.betweenness_centrality(graph1G, normalized=False)
        degreeGraph2 = nx.betweenness_centrality(graph2G, normalized=False)
        degreeGraph3 = nx.betweenness_centrality(graph3G, normalized=False)
        degreeGraph4 = nx.betweenness_centrality(graph4G, normalized=False)
        degreeGraph5 = nx.betweenness_centrality(graph5G, normalized=False)
        degreeQ2Seed1 = nx.betweenness_centrality(q2seed1G, normalized=False)
        degreeQ2Seed3 = nx.betweenness_centrality(q2seed3G, normalized=False)
        degreeQ3Seed1 = nx.betweenness_centrality(q3seed1G, normalized=False)
        degreeQ3Seed3 = nx.betweenness_centrality(q3seed3G, normalized=False)

    elif option_slctd == "eigenvector":
        degreeTemplate = nx.eigenvector_centrality(templateG)
        degreeGraph1 = nx.eigenvector_centrality(graph1G)
        degreeGraph2 = nx.eigenvector_centrality(graph2G)
        degreeGraph3 = nx.eigenvector_centrality(graph3G)
        degreeGraph4 = nx.eigenvector_centrality(graph4G)
        degreeGraph5 = nx.eigenvector_centrality(graph5G)
        degreeQ2Seed1 = nx.eigenvector_centrality(q2seed1G)
        degreeQ2Seed3 = nx.eigenvector_centrality(q2seed3G)
        degreeQ3Seed1 = nx.eigenvector_centrality(q3seed1G)
        degreeQ3Seed3 = nx.eigenvector_centrality(q3seed3G)
        measure = "Eigenvector_Centrality"

    elif option_slctd == "out_degree":
        degreeTemplate = templateG.out_degree()
        degreeGraph1 = graph1G.out_degree()
        degreeGraph2 = graph2G.out_degree()
        degreeGraph3 = graph3G.out_degree()
        degreeGraph4 = graph4G.out_degree()
        degreeGraph5 = graph5G.out_degree()
        degreeQ2Seed1 = q2seed1G.out_degree()
        degreeQ2Seed3 = q2seed3G.out_degree()
        degreeQ3Seed1 = q3seed1G.out_degree()
        degreeQ3Seed3 = q3seed3G.out_degree()
        measure = "Out-Degree"

    # elif option_slctd == "q1graph3":
    #     title = "Q1 Graph-3"
    #     df = normalized_dfT4.copy()
    #
    # elif option_slctd == "q1graph4":
    #     title = "Q1 Graph-4"
    #     df = normalized_dfT5.copy()
    #
    # elif option_slctd == "q1graph5":
    #     title = "Q1 Graph-5"
    #     df = normalized_dfT6.copy()
    #
    # elif option_slctd == "q2graph1":
    #     title = "Q2 Graph-1"
    #     df = normalized_dfT7.copy()
    #
    # elif option_slctd == "q2graph3":
    #     title = "Q2 Graph-3"
    #     df = normalized_dfT8.copy()
    #
    # elif option_slctd == "q3graph1":
    #     title = "Q3 Graph-1"
    #     df = normalized_dfT9.copy()
    #
    # elif option_slctd == "q3graph2":
    #     title = "Q3 Graph-2"
    #     df = normalized_dfT10.copy()

    container = "Upper Graph: Template | Lower Graph: {}".format(measure)

    if option_slctd in ["betweenness", "eigenvector"]:
        # Add histogram data
        df = pd.DataFrame(list(dict(degreeTemplate).values()))
        x1 = df[0]

        df = pd.DataFrame(list(dict(degreeGraph1).values()))
        x2 = df[0]

        df = pd.DataFrame(list(dict(degreeGraph2).values()))
        x3 = df[0]

        df = pd.DataFrame(list(dict(degreeGraph3).values()))
        x4 = df[0]

        df = pd.DataFrame(list(dict(degreeGraph4).values()))
        x5 = df[0]

        df = pd.DataFrame(list(dict(degreeGraph5).values()))
        x6 = df[0]

        df = pd.DataFrame(list(dict(degreeQ2Seed1).values()))
        x7 = df[0]

        df = pd.DataFrame(list(dict(degreeQ2Seed3).values()))
        x8 = df[0]

        df = pd.DataFrame(list(dict(degreeQ3Seed1).values()))
        x9 = df[0]

        df = pd.DataFrame(list(dict(degreeQ3Seed3).values()))
        x10 = df[0]

    else:

        # Add histogram data
        df = pd.DataFrame(list(zip([y for x, y in degreeTemplate], [x for x, y in degreeTemplate])))
        x1 = df[0]

        df = pd.DataFrame(list(zip([y for x, y in degreeGraph1], [x for x, y in degreeGraph1])))
        x2 = df[0]

        df = pd.DataFrame(list(zip([y for x, y in degreeGraph2], [x for x, y in degreeGraph2])))
        x3 = df[0]

        df = pd.DataFrame(list(zip([y for x, y in degreeGraph3], [x for x, y in degreeGraph3])))
        x4 = df[0]

        df = pd.DataFrame(list(zip([y for x, y in degreeGraph4], [x for x, y in degreeGraph4])))
        x5 = df[0]

        df = pd.DataFrame(list(zip([y for x, y in degreeGraph5], [x for x, y in degreeGraph5])))
        x6 = df[0]

        df = pd.DataFrame(list(zip([y for x, y in degreeQ2Seed1], [x for x, y in degreeQ2Seed1])))
        x7 = df[0]

        df = pd.DataFrame(list(zip([y for x, y in degreeQ2Seed3], [x for x, y in degreeQ2Seed3])))
        x8 = df[0]

        df = pd.DataFrame(list(zip([y for x, y in degreeQ3Seed1], [x for x, y in degreeQ3Seed1])))
        x9 = df[0]

        df = pd.DataFrame(list(zip([y for x, y in degreeQ3Seed3], [x for x, y in degreeQ3Seed3])))
        x10 = df[0]

    # Group data together
    hist_data = [x1, x2, x3, x4, x5, x6, x7, x8, x9, x10]

    group_labels = ['Template', 'Q1 Graph 1', 'Q1 Graph 2', 'Q1 Graph 3', 'Q1 Graph 4', 'Q1 Graph 5', 'Q2 Graph 1',
                    'Q2 Graph 3', 'Q3 Graph 1', 'Q3 Graph 2']

    # Create distplot with custom bin_size
    fig = ff.create_distplot(hist_data, group_labels, bin_size=4, show_hist=False)

    # fig.update_layout(
    #     title="Distribution curve for " + str(measure),
    #     xaxis_title="Frequency",
    #     yaxis_title="Probability",
    #     font=dict(
    #         family="Courier New, monospace",
    #         size=18,
    #         color="#7f7f7f"
    #     )
    # )

    container = "Upper Graph: Template | Lower Graph: {}".format(measure)
    container = str(container)



    return container, fig


# ------------------------------------------------------------------------------
if __name__ == '__main__':
    app.run_server(debug=True)

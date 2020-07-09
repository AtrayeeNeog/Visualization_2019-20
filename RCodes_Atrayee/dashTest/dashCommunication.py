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

external_stylesheets = ['https://codepen.io/chriddyp/pen/bWLwgP.css']

app = dash.Dash(__name__, external_stylesheets=external_stylesheets)


#-------------------------------------
#Loading and cleaning the data
path = Path(__file__).parent / "\\OVGU\\WiSe19_20\\VA project\\GitHub\\Visuaization_2019-20\\python\\dashTest\\data"
pathCSV = str(path) + "\\CGCS-Template.csv"
dfTemplate = pd.read_csv(pathCSV)
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


#-------------------------------------------------------------
#App layout
app.layout = html.Div([
    dcc.Dropdown(
        id='opt',
        options=[
            {'label': 'test', 'value': 'test'},
            {'label': 'Q1 Graph 1', 'value': 'Q1Graph1'},
            {'label': 'Q1 Graph 2', 'value': 'Q1Graph2'},
            {'label': 'Template', 'value': 'Template'},
            {'label': 'Q3 Graph2', 'value': "q3graph2"}
        ],
        value='NYC'
    ),
    html.Div(id='dd-output-container'),
    html.Br(),

    dcc.Graph(id="plot", figure={})

])


# @app.callback(
#     dash.dependencies.Output('dd-output-container', 'children'),
#     [dash.dependencies.Input('demo-dropdown', 'value')])

@app.callback(Output('plot', 'figure'),
             [Input('opt', 'value')])
def update_output(value):

    if value == "test":
        fig = px.scatter(x=[0, 1, 2, 3, 4], y=[0, 1, 4, 9, 16])
        fig.show()
        # return 'You have selected "{}"'.format(template)
        return fig
    elif value == "Q1Graph1":
        out = [int(x/10) for x in q1Graph1]
        fig = px.scatter(x=[0, 1, 2, 3, 4], y=[0, 1, 4, 9, 16])
        fig.show()
        return 'You have selected "{}"'.format(out)
    elif value == "Q1Graph2":
        out = [int(x / 10) for x in q1Graph2]
        fig = px.scatter(x=[0, 1, 2, 3, 4], y=[0, 1, 4, 9, 16])
        fig.show()
        return 'You have selected "{}"'.format(out)
    elif value == "Template":
        fig = px.scatter(x=[0, 1, 2, 3, 4], y=[0, 1, 4, 9, 16])
        fig.show()
        return "The lenght of the the '{}' is '{}' ".format(str(value), len(dfTemplate))
    elif value == "q3graph2":
        fig = px.scatter(x=[0, 1, 2, 3, 4], y=[0, 1, 4, 9, 16])
        fig.show()
        return "Tuple values just to test '{}'".format(str(q3seed3NodesTuple))
    else:
        return "Nothing is selected"


if __name__ == '__main__':
    template = [1, 3, 5]
    q1Graph1 = [50, 60, 90]
    q1Graph2 = [300, 900, 700]
    # my_path = os.path.abspath(os.path.dirname(__file__))
    # path = os.path.join(my_path, "\\data\\CGCS-Template.csv")



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
    print("")


    app.run_server(debug=True)

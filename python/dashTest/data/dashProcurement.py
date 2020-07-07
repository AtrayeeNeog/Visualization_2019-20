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
pathCSV = str(path) + "\\DemographicCategories.csv"
dfCategory = pd.read_csv(pathCSV)

# ------------------------------------------------------------------------------
# App layout
app.layout = html.Div([

    html.H1("Procurement Channel", style={'text-align': 'center'}),




    dcc.Dropdown(id="slct_comparison_graph",
                 options=[
                     {"label": "Template", "value": "template"},
                     {"label": "Q1 Graph1", "value": "q1graph1"},
                     {"label": "Q1 Graph2", "value": "q1graph2"},
                     {"label": "Q1 Graph3", "value": "q1graph3"},
                     {"label": "Q1 Graph4", "value": "q1graph4"},
                     {"label": "Q1 Graph5", "value": "q1graph5"},
                     {"label": "Q2 Graph1", "value": "q2graph1"},
                     {"label": "Q2 Graph3", "value": "q2graph3"},
                     {"label": "Q3 Graph1", "value": "q3graph1"},
                     {"label": "Q3 Graph2", "value": "q3graph2"},
                     {"label": "Default", "value": "test"}],
                 multi=False,
                 value="template",
                 placeholder="Select Graph to compare",
                 style=dict(
                     width='40%',
                     verticalAlign="right"
                 )
                 ),

    html.Div(id='output_container', children=[]),
    html.Br(),
    html.Div([
        dcc.Graph(id='template_graph', figure={}, config={'displayModeBar': False}),
    ], style={'width': '49%', 'display': 'inline-block', 'padding': '0 20'}),
    html.Div([
        dcc.Graph(id='comparison_graph', figure={}, config={'displayModeBar': False})
    ], style={'display': 'inline-block', 'width': '49%'})





])


# ------------------------------------------------------------------------------
# Connect the Plotly graphs with Dash Components
@app.callback(
    [Output(component_id='output_container', component_property='children'),
     Output(component_id='template_graph', component_property='figure'),
     Output(component_id='comparison_graph', component_property='figure')],
    [Input(component_id='slct_comparison_graph', component_property='value')]
)
def update_graph(option_slctd):
    print(option_slctd)
    print(type(option_slctd))

    df = dfTemplate
    title = "Template"

    # figT =
    df = df[(df["eType"] == 2) | (df["eType"] == 3)]

    source0StringList = [str(x) for x in df["Source"]]
    etype0 = [str(x) for x in df["eType"]]
    weight0StringList = [int(abs(x)) for x in list(df["Weight"])]
    time0 = df[(df["eType"] == 2) | (df["eType"] == 3)]["Time"] / (24 * 3600)

    figT = px.scatter(x=source0StringList, y=time0, size=weight0StringList, color=etype0)
    figT.update_layout(title_text="Procurement channel for " + title, )
    figT.update_yaxes(showticklabels=True)

    figT.update_layout(height=600, margin={'l': 20, 'b': 30, 'r': 10, 't': 30})
    figT.update_layout(
        title={
            'y': 1.0,
            'x': 0.3,
            'xanchor': 'center',
            'yanchor': 'top'},
        xaxis_title="Person Id",
        yaxis_title="Time(days)")

    if option_slctd == "default":
        title = "Template"
        df = dfTemplate.copy()

    elif option_slctd == "q1graph1":
        title = "Q1 Graph-1"
        df = dfGraph1.copy()

    elif option_slctd == "q1graph2":
        title = "Q1 Graph-2"
        df = dfGraph2.copy()

    elif option_slctd == "q1graph3":
        title = "Q1 Graph-3"
        df = dfGraph3.copy()

    elif option_slctd == "q1graph4":
        title = "Q1 Graph-4"
        df = dfGraph4.copy()

    elif option_slctd == "q1graph5":
        title = "Q1 Graph-5"
        df = dfGraph5.copy()

    elif option_slctd == "q2graph1":
        title = "Q2 Graph-1"
        df = dfQ2Seed1.copy()

    elif option_slctd == "q2graph3":
        title = "Q2 Graph-3"
        df = dfQ2Seed3.copy()

    elif option_slctd == "q3graph1":
        title = "Q3 Graph-1"
        df = dfQ3Seed1.copy()

    elif option_slctd == "q3graph2":
        title = "Q3 Graph-2"
        df = dfQ3Seed3.copy()

    df = df[(df["eType"] == 2) | (df["eType"] == 3)]

    container = "Upper Graph: Template | Lower Graph: {}".format(title)

    return container, figT, figT


# ------------------------------------------------------------------------------
if __name__ == '__main__':
    app.run_server(debug=True)

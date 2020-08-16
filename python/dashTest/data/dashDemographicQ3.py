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

    html.H1("Demographic Channel", style={'text-align': 'center'}),


    html.Div(id='output_container', children=[]),
    html.Br(),
    html.Div([
        dcc.Graph(id='template_graph', figure={}, config={'displayModeBar': False}),
    ], style={'width': '49%', 'display': 'inline-block', 'padding': '0 20'}),
    html.Div([
        dcc.Dropdown(id="slct_comparison_graph",
             options=[
                 {"label": "Template", "value": "template"},
                 {"label": "Q1 Graph2", "value": "q1graph2"},
                 {"label": "Q3 Graph1", "value": "q3graph1"},
                 {"label": "Q3 Graph2", "value": "q3graph2"},
                 {"label": "Default", "value": "test"}],
             multi=False,
             value="template",
             placeholder="Select Graph to compare",
             style=dict(
                 width='60%',
                 verticalAlign="right"
             )
             ),

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
    source0StringList, target0StringList, weight0StringList = list(), list(), list()
    data = dict()
    for edge in range(len(df[df["eType"] == 5])):
        if (df[df["eType"] == 5].iloc[edge]["Source"] not in list(dfCategory["NodeID"])):
            source0StringList.append([int(df[df["eType"] == 5].iloc[edge]["Source"])])
            target0StringList.append(list([int(df[df["eType"] == 5].iloc[edge]["Target"])]))
            weight0StringList.append([int(df[df["eType"] == 5].iloc[edge]["Weight"])])

        else:
            source0StringList.append(list([int(df[df["eType"] == 5].iloc[edge]["Target"])]))
            target0StringList.append(list([int(df[df["eType"] == 5].iloc[edge]["Source"])]))
            weight0StringList.append([-1 * int(df[df["eType"] == 5].iloc[edge]["Weight"])])

    source0StringList = [str(x) for x in source0StringList]
    # target0StringList = [str(x) for x in target0StringList]
    weight0StringList = [int(abs(x[0])) for x in weight0StringList]
    target0StringList = [dfCategory[dfCategory["NodeID"] == int(x[0])].iloc[0]["Category"] for x in target0StringList]

    for i in range(len(source0StringList)):
        data[str(i)] = [target0StringList[i], source0StringList[i], weight0StringList[i]]

    sorted_data = sorted(data.items(), key=operator.itemgetter(1))

    target0StringList = [row[1][0] for row in sorted_data]
    source0StringList = [row[1][1] for row in sorted_data]
    weight0StringList = [row[1][2] for row in sorted_data]

    # df[df["eType"] == 5]["Weight"]
    # source0StringList = source0StringList + [source0StringList[0]] * 29
    # target0StringList = target0StringList + list(dfCategory["Category"])
    # weight0StringList = weight0StringList + [0] * 29

    figT = px.scatter(x=source0StringList, y=target0StringList, size=weight0StringList, color=target0StringList)
    figT.update_layout(title_text="Demographic channel for " + title, )
    figT.update_yaxes(showticklabels=False)

    figT.update_layout(height=600, margin={'l': 20, 'b': 30, 'r': 10, 't': 50})
    figT.update_layout(
        title={
            'y': 0.98,
            'x': 0.3,
            'xanchor': 'center',
            'yanchor': 'top'},
        xaxis_title = "Person Id",
        yaxis_title = "Category")


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

    df = df[df["eType"] == 5]

    container = "Left Graph: Template | Right Graph: {}".format(title)

    source0StringList, target0StringList, weight0StringList = list(), list(), list()
    data = dict()
    for edge in range(len(df[df["eType"] == 5])):
        if (df[df["eType"] == 5].iloc[edge]["Source"] not in list(dfCategory["NodeID"])):
            source0StringList.append([int(df[df["eType"] == 5].iloc[edge]["Source"])])
            target0StringList.append(list([int(df[df["eType"] == 5].iloc[edge]["Target"])]))
            weight0StringList.append([int(df[df["eType"] == 5].iloc[edge]["Weight"])])

        else:
            source0StringList.append(list([int(df[df["eType"] == 5].iloc[edge]["Target"])]))
            target0StringList.append(list([int(df[df["eType"] == 5].iloc[edge]["Source"])]))
            weight0StringList.append([-1 * int(df[df["eType"] == 5].iloc[edge]["Weight"])])

    source0StringList = [str(x) for x in source0StringList]
    # target0StringList = [str(x) for x in target0StringList]
    weight0StringList = [int(abs(x[0])) for x in weight0StringList]
    target0StringList = [dfCategory[dfCategory["NodeID"] == int(x[0])].iloc[0]["Category"] for x in target0StringList]

    for i in range(len(source0StringList)):
        data[str(i)] = [target0StringList[i], source0StringList[i], weight0StringList[i]]

    sorted_data = sorted(data.items(), key=operator.itemgetter(1))

    target0StringList = [row[1][0] for row in sorted_data]
    source0StringList = [row[1][1] for row in sorted_data]
    weight0StringList = [row[1][2] for row in sorted_data]

    fig = px.scatter(x=source0StringList, y=target0StringList, size=weight0StringList, color=target0StringList)
    fig.update_layout(title_text="Demographic channel for " + title, )
    fig.update_yaxes(showticklabels=False)

    fig.update_layout(height=600, margin={'l': 20, 'b': 30, 'r': 10, 't': 50})
    figT.update_layout(
        title={
            'y': 1.0,
            'x': 0.5,
            'xanchor': 'center',
            'yanchor': 'top'},
        title_text="Demographic channel",
        xaxis_title="Person Id",
        yaxis_title="Category",
        height=650,
        margin={'l': 20, 'b': 30, 'r': 10, 't': 60},
        font=dict(
            family="TXTT",
            size=30,
            color="black"
        ),
        legend=dict(
            font=dict(
                family="TXTT",
                size=14,
                color="black"
            ),
        )
    )
    figT.update_xaxes(
        tickfont=dict(
            family='TXTT',
            size=18,
            color='black'
        ),
    )
    figT.update_yaxes(
        tickfont=dict(
            family='TXTT',
            size=25,
            color='black'
        ),
    )

    return container, figT, fig


# ------------------------------------------------------------------------------
if __name__ == '__main__':
    app.run_server(debug=False)

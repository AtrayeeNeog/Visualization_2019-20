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
pathCSV = str(path) + "\\DemographicCategories.csv"
dfCategory = pd.read_csv(pathCSV)

# ------------------------------------------------------------------------------
# App layout
app.layout = html.Div([

    html.H1("Parallel Coordinates Comparisons", style={'text-align': 'center'}),

    dcc.Dropdown(id="slct_comparison_graph",
                 options=[
                     {"label": "test", "value": "test"},
                     {"label": "Template vs Q1 Graph1", "value": "q1graph1"},
                     {"label": "Template vs Q1 Graph2", "value": "q1graph2"},
                     {"label": "Template vs Q1 Graph3", "value": "q1graph3"},
                     {"label": "Template vs Q1 Graph4", "value": "q1graph4"},
                     {"label": "Template vs Q1 Graph5", "value": "q1graph5"},
                     {"label": "Template vs Q2 Graph1", "value": "q2graph1"},
                     {"label": "Template vs Q2 Graph3", "value": "q2graph3"},
                     {"label": "Template vs Q3 Graph1", "value": "q3graph1"},
                     {"label": "Template vs Q3 Graph2", "value": "q3graph2"}],
                 multi=False,
                 value="Initial",
                 style={'width': "40%"}
                 ),

    html.Div(id='output_container', children=[]),
    html.Br(),
    dcc.Graph(id='template_graph', figure={}, config={'displayModeBar': True}),
    dcc.Graph(id='comparison_graph', figure={}, config={'displayModeBar': True})

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


    title = "Template"

    # figT =
    title = "Template"

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

    container = "Upper Graph: Template | Lower Graph: {}".format(title)

    f = plt.figure(figsize=(20, 10))

    time0 = df[(df["eType"] == 0)]["Time"] / (24 * 3600)
    time1 = df[(df["eType"] == 1)]["Time"] / (24 * 3600)

    source0StringList, target0StringList = list(), list()
    for edge in range(len(df[df["eType"] == 5])):
        if (df[df["eType"] == 5].iloc[edge]["Source"] not in list(dfCategory["NodeID"])):
            source0StringList.append([int(df[df["eType"] == 5].iloc[edge]["Source"])])
            target0StringList.append(list([int(df[df["eType"] == 5].iloc[edge]["Target"])]))
        else:
            source0StringList.append(list([int(df[df["eType"] == 5].iloc[edge]["Target"])]))
            target0StringList.append(list([int(df[df["eType"] == 5].iloc[edge]["Source"])]))

    source0StringList = [str(x) for x in source0StringList]
    # target0StringList = [str(x) for x in target0StringList]
    target0StringList = [dfCategory[dfCategory["NodeID"] == int(x[0])].iloc[0]["Category"] for x in target0StringList]
    fig = px.scatter(x=source0StringList, y=target0StringList, size=df[df["eType"] == 5]["Weight"],
                     color=target0StringList)

    fig.update_layout(title_text="Degmographic channel for " + title, )
    # fig.show()
    fig.update_layout(
        plot_bgcolor='white',
        paper_bgcolor='white',
        title_text="Parallel Coordinates of " + str(title) + "'s all the measurements"
    )
    # fig.update_layout(height=450, width=1500)
    fig.update_layout(height=300, margin={'l': 20, 'b': 30, 'r': 10, 't': 60})
    fig.update_layout(
        title={
            'y': 1.0,
            'x': 0.5,
            'xanchor': 'center',
            'yanchor': 'top'})

    return container, fig, fig


# ------------------------------------------------------------------------------
if __name__ == '__main__':
    app.run_server(debug=True)

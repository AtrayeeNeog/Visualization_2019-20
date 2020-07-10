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


template_targets_options = list(dict.fromkeys(dfTemplate[dfTemplate['eType'] == 6]["Target"]))

all_options = {
    'template': list(dict.fromkeys(dfTemplate[(dfTemplate['eType'] == 2) | (dfTemplate['eType'] == 3)]["Target"])),
    'q1graph1': list(dict.fromkeys(dfGraph1[(dfGraph1['eType'] == 2) | (dfGraph1['eType'] == 3)]["Target"])),
    'q1graph2': list(dict.fromkeys(dfGraph2[(dfGraph2['eType'] == 2) | (dfGraph2['eType'] == 3)]["Target"])),
    'q1graph3': list(dict.fromkeys(dfGraph3[(dfGraph3['eType'] == 2) | (dfGraph3['eType'] == 3)]["Target"])),
    'q1graph4': list(dict.fromkeys(dfGraph4[(dfGraph4['eType'] == 2) | (dfGraph4['eType'] == 3)]["Target"])),
    'q1graph5': list(dict.fromkeys(dfGraph5[(dfGraph5['eType'] == 2) | (dfGraph5['eType'] == 3)]["Target"])),
    'q2graph1': list(dict.fromkeys(dfQ2Seed1[(dfQ2Seed1['eType'] == 2) | (dfQ2Seed1['eType'] == 3)]["Target"])),
    'q2graph3': list(dict.fromkeys(dfQ2Seed3[(dfQ2Seed3['eType'] == 2) | (dfQ2Seed3['eType'] == 3)]["Target"])),
    'q3graph1': list(dict.fromkeys(dfQ3Seed1[(dfQ3Seed1['eType'] == 2) | (dfQ3Seed1['eType'] == 3)]["Target"])),
    'q3graph2': list(dict.fromkeys(dfQ3Seed3[(dfQ3Seed3['eType'] == 2) | (dfQ3Seed3['eType'] == 3)]["Target"])),
    'test': list(dict.fromkeys(dfTemplate[(dfTemplate['eType'] == 2) | (dfTemplate['eType'] == 3)]["Target"])),

}


# ------------------------------------------------------------------------------
# App layout
app.layout = html.Div([

    html.H1("Procurement Channel", style={'text-align': 'center'}),






    html.Div(id='output_container', children=[]),
    html.Br(),
    html.Div([
        dcc.Dropdown(id="slct_comparison_graph",
                     options=[
                         {"label": "Template", "value": "template"},
                         {"label": "Q1 Graph1", "value": "q1graph1"},
                         {"label": "Q1 Graph2", "value": "q1graph2"},
                         {"label": "Q1 Graph3", "value": "q1graph3"},
                         {"label": "Q1 Graph4", "value": "q1graph4"},
                         {"label": "Q1 Graph5", "value": "q1graph5"},
                         {"label": "Default", "value": "test"}],
                     multi=False,
                     value="template",
                     placeholder="Select Graph to compare",
                     style=dict(
                         width='50%',
                         verticalAlign="right"
                     )
                     ),
        # dcc.RadioItems(id="target_radio"),
        # dcc.RadioItems(id='target_radio'),

        dcc.Graph(id='template_graph', figure={}, config={'displayModeBar': False}),
    ], style={'width': '49%', 'display': 'inline-block', 'padding': '0 20'}),


    html.Div([
        dcc.Dropdown(id="slct_comparison_graph2",
                     options=[
                         {"label": "Template", "value": "template"},
                         {"label": "Q1 Graph1", "value": "q1graph1"},
                         {"label": "Q1 Graph2", "value": "q1graph2"},
                         {"label": "Q1 Graph3", "value": "q1graph3"},
                         {"label": "Q1 Graph4", "value": "q1graph4"},
                         {"label": "Q1 Graph5", "value": "q1graph5"},
                         {"label": "Default", "value": "test"}],
                     multi=False,
                     value="template",
                     placeholder="Select Graph to compare",
                     style=dict(
                         width='50%',
                         verticalAlign="right"
                     )
                     ),
        # dcc.RadioItems(id="target2_radio"),
        dcc.Graph(id='comparison_graph', figure={}, config={'displayModeBar': False})
    ], style={'display': 'inline-block', 'width': '49%'})





])


# ------------------------------------------------------------------------------
# Connect the Plotly graphs with Dash Components
# @app.callback(
#     Output('target_radio', 'options'),
#     [Input(component_id='slct_comparison_graph', component_property='value')])
# def set_cities_options(selected_graph):
#     return [{'label': i, 'value': i} for i in all_options[selected_graph]]
#
#
# @app.callback(
#     Output('target2_radio', 'options'),
#     [Input(component_id='slct_comparison_graph2', component_property='value')])
# def set_cities_options(selected_graph):
#     return [{'label': i, 'value': i} for i in all_options[selected_graph]]


@app.callback(
    [Output(component_id='output_container', component_property='children'),
     Output(component_id='template_graph', component_property='figure'),
     Output(component_id='comparison_graph', component_property='figure')],
    [Input(component_id='slct_comparison_graph', component_property='value'),
     Input(component_id='slct_comparison_graph2', component_property='value'),]
)
def update_graph(slct_comparison_graph_value, slct_comparison_graph2_value):
    print(slct_comparison_graph_value)
    print(type(slct_comparison_graph_value))
    df = dfTemplate
    title = "Procurement"
    if slct_comparison_graph_value == "default":
        title = "Template"
        df = dfTemplate.copy()

    if slct_comparison_graph_value == "template":
        title = "Template"
        df = dfTemplate.copy()

    elif slct_comparison_graph_value == "q1graph1":
        title = "Q1 Graph-1"
        df = dfGraph1.copy()

    elif slct_comparison_graph_value == "q1graph2":
        title = "Q1 Graph-2"
        df = dfGraph2.copy()

    elif slct_comparison_graph_value == "q1graph3":
        title = "Q1 Graph-3"
        df = dfGraph3.copy()

    elif slct_comparison_graph_value == "q1graph4":
        title = "Q1 Graph-4"
        df = dfGraph4.copy()

    elif slct_comparison_graph_value == "q1graph5":
        title = "Q1 Graph-5"
        df = dfGraph5.copy()

    elif slct_comparison_graph_value == "q2graph1":
        title = "Q2 Graph-1"
        df = dfQ2Seed1.copy()

    elif slct_comparison_graph_value == "q2graph3":
        title = "Q2 Graph-3"
        df = dfQ2Seed3.copy()

    elif slct_comparison_graph_value == "q3graph1":
        title = "Q3 Graph-1"
        df = dfQ3Seed1.copy()

    elif slct_comparison_graph_value == "q3graph2":
        title = "Q3 Graph-2"
        df = dfQ3Seed3.copy()

    df = df[(df["eType"] == 2) | (df["eType"] == 3)]

    # if len(slct_graph_target) > 0:
    #     df2 = df.copy()
    #     df = df[df["eType"] == -100]
    #     for target in slct_graph_target:
    #         df = df.append(df2[df2["Target"] == target])

    sourceIn = [str([x]) for x in df['Source']]
    targetIn = [str(x) for x in df['Target']]
    etypein = [str(x) for x in df['eType']]
    weightIn = [abs(int(x)) for x in df['Weight']]
    fig = px.scatter(x=sourceIn, y=df["Time"]/(24*3600), color=etypein, symbol=targetIn,
                      size=weightIn, hover_data=[weightIn])

    fig.update_layout(
        title="Procurement Channel of " + str(title),
        xaxis_title="Source Id",
        yaxis_title="Time(days)",
        font=dict(
            family="Courier New, monospace",
            size=18,
            color="#000000"
        )
    )

    if slct_comparison_graph2_value == "default":
        title = "Template"
        df = dfTemplate.copy()

    if slct_comparison_graph2_value == "template":
        title = "Template"
        df = dfTemplate.copy()

    elif slct_comparison_graph2_value == "q1graph1":
        title = "Q1 Graph-1"
        df = dfGraph1.copy()

    elif slct_comparison_graph2_value == "q1graph2":
        title = "Q1 Graph-2"
        df = dfGraph2.copy()

    elif slct_comparison_graph2_value == "q1graph3":
        title = "Q1 Graph-3"
        df = dfGraph3.copy()

    elif slct_comparison_graph2_value == "q1graph4":
        title = "Q1 Graph-4"
        df = dfGraph4.copy()

    elif slct_comparison_graph2_value == "q1graph5":
        title = "Q1 Graph-5"
        df = dfGraph5.copy()

    elif slct_comparison_graph2_value == "q2graph1":
        title = "Q2 Graph-1"
        df = dfQ2Seed1.copy()

    elif slct_comparison_graph2_value == "q2graph3":
        title = "Q2 Graph-3"
        df = dfQ2Seed3.copy()

    elif slct_comparison_graph2_value == "q3graph1":
        title = "Q3 Graph-1"
        df = dfQ3Seed1.copy()

    elif slct_comparison_graph2_value == "q3graph2":
        title = "Q3 Graph-2"
        df = dfQ3Seed3.copy()

    df = df[(df["eType"] == 2) | (df["eType"] == 3)]

    # if len(slct_graph2_target) > 0:
    #     df2 = df.copy()
    #     df = df[df["eType"] == -100]
    #     for target in slct_graph2_target:
    #         df = df.append(df2[df2["Target"] == target])

    sourceIn = [str([x]) for x in df['Source']]
    targetIn = [str(x) for x in df['Target']]
    etypein = [str(x) for x in df['eType']]
    weightIn = [abs(int(x)) for x in df['Weight']]
    figT = px.scatter(x=sourceIn, y=df["Time"]/(24*3600), color=etypein, symbol=targetIn,
                      size=weightIn, hover_data=[weightIn])

    figT.update_layout(
        title="Procurement Channel of " + str(title),
        xaxis_title="Source Id",
        yaxis_title="Time(days)",
        font=dict(
            family="Courier New, monospace",
            size=18,
            color="#000000"
        )
    )

    container = "Left Graph: Template | Right Graph: {}".format(str(title))

    return container, fig, figT


# ------------------------------------------------------------------------------
if __name__ == '__main__':
    app.run_server(debug=True)

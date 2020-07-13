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
pathCSV = str(path) + "\\procurement.csv"
dfProcurement = pd.read_csv(pathCSV)
# dfTemplate = pd.read_csv("CGCS-Template.csv")
# pathCSV = str(path) + "\\Q1-Graph1.csv"
# dfGraph1 = pd.read_csv(pathCSV)
# pathCSV = str(path) + "\\Q1-Graph2.csv"
# dfGraph2 = pd.read_csv(pathCSV)
# pathCSV = str(path) + "\\Q1-Graph3.csv"
# dfGraph3 = pd.read_csv(pathCSV)
# pathCSV = str(path) + "\\Q1-Graph4.csv"
# dfGraph4 = pd.read_csv(pathCSV)
# pathCSV = str(path) + "\\Q1-Graph5.csv"
# dfGraph5 = pd.read_csv(pathCSV)
# pathCSV = str(path) + "\\dfSeed1Reduced.csv"
# dfQ2Seed1 = pd.read_csv(pathCSV)
# pathCSV = str(path) + "\\dfSeed3Reduced.csv"
# dfQ2Seed3 = pd.read_csv(pathCSV)
# pathCSV = str(path) + "\\dfProcSeed1-Graph2ReducedFinal.csv"
# dfQ3Seed1 = pd.read_csv(pathCSV)
# pathCSV = str(path) + "\\dfProcSeed3-Graph2ReducedFinal.csv"
# dfQ3Seed3 = pd.read_csv(pathCSV)
# pathCSV = str(path) + "\\DemographicCategories.csv"
# dfCategory = pd.read_csv(pathCSV)


# template_targets_options = list(dict.fromkeys(dfProcurement[dfProcurement['eType'] == 6]["Target"]))

all_options = {'procurement': list(dict.fromkeys(dfProcurement["Target"])),

}


# ------------------------------------------------------------------------------
# App layout
app.layout = html.Div([

    html.H1("Procurement channel", style={'text-align': 'center'}),






    html.Div(id='output_container', children=[]),
    html.Br(),
    html.Div([
        dcc.Dropdown(id="slct_comparison_graph",
                     options=[
                         {"label": "Procurement channel", "value": "procurement"}],
                     multi=False,
                     value="procurement",
                     placeholder="Select Graph to compare",
                     style=dict(
                         width='50%',
                         verticalAlign="right"
                     )
                     ),
        dcc.Dropdown(id="target_radio",
                     options=[
                         {"label": "Procurement channel", "value": "procurement"}],
                     multi=True,
                     value=[],
                     placeholder="Select Graph to compare",
                     style=dict(
                         width='80%',
                         verticalAlign="right"
                     )
                     ),
        # dcc.RadioItems(id='target_radio'),

        dcc.Graph(id='comparison_graph', figure={}, config={'displayModeBar': False}),
    ], style={'width': '98%', 'display': 'inline-block', 'padding': '0 20'})





])


# ------------------------------------------------------------------------------
# Connect the Plotly graphs with Dash Components
@app.callback(
    Output('target_radio', 'options'),
    [Input(component_id='slct_comparison_graph', component_property='value')])
def set_cities_options(selected_graph):
    return [{'label': i, 'value': i} for i in all_options[selected_graph]]



@app.callback(
    [Output(component_id='output_container', component_property='children'),
     Output(component_id='comparison_graph', component_property='figure')],
    [Input(component_id='slct_comparison_graph', component_property='value'),
     Input(component_id='target_radio', component_property='value')]
)
def update_graph(slct_comparison_graph_value, slct_graph_target):
    print(slct_comparison_graph_value)
    print(type(slct_comparison_graph_value))
    df = dfProcurement
    title = "Procurement channel"


    if len(slct_graph_target) > 0:
        df2 = df.copy()
        df = df[df["eType"] == -100]
        for target in slct_graph_target:
            df = df.append(df2[df2["Target"] == target])

    sourceIn = [str([x]) for x in df['Source']]
    targetIn = [str(x) for x in df['Target']]
    weightIn = [abs(int(x)) for x in df['Weight']]
    etypeIn = [str(x) for x in df['eType']]

    fig = px.scatter(x=df["Time"]/(24*3600), y=sourceIn, color=etypeIn, size=weightIn,
                     hover_data=[weightIn], symbol=targetIn)
    fig.update_layout(height=600, margin={'l': 20, 'b': 30, 'r': 10, 't': 60})

    container = "Upper Graph: Template | Lower Graph: {}".format(str(title))

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

    return container, fig


# ------------------------------------------------------------------------------
if __name__ == '__main__':
    app.run_server(debug=False)

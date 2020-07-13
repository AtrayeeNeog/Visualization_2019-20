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
pathCSV = str(path) + "\\dfTravel.csv"
dfTravel = pd.read_csv(pathCSV)

all_options = {
    'travel': list(dict.fromkeys(dfTravel[dfTravel['eType'] == 6]["Target"])),
}


# ------------------------------------------------------------------------------
# App layout
app.layout = html.Div([

    html.H1("Travel Channel", style={'text-align': 'center'}),






    html.Div(id='output_container', children=[]),
    html.Br(),
    html.Div([
        dcc.Dropdown(id="slct_comparison_graph",
                     options=[
                         {"label": "Travel channel", "value": "travel"}],
                     multi=False,
                     value="travel",
                     placeholder="Select Graph to compare",
                     style=dict(
                         width='50%',
                         verticalAlign="right"
                     )
                     ),
        dcc.Dropdown(id="target_radio",
                     options=[
                         {"label": "Travel channel", "value": "travel"}],
                     multi=True,
                     value=[],
                     placeholder="Select Targets to display",
                     style=dict(
                         width='60%',
                         verticalAlign="right"
                     )
                     ),
        # dcc.RadioItems(id='target_radio'),

        dcc.Graph(id='travel_graph', figure={}, config={'displayModeBar': False}),
    ], style={'width': '99%', 'display': 'inline-block', 'padding': '0 20'}),







])


# ------------------------------------------------------------------------------
# Connect the Plotly graphs with Dash Components
@app.callback(
    Output('target_radio', 'options'),
    [Input(component_id='slct_comparison_graph', component_property='value')])
def set_cities_options(selected_graph):
    return [{'label': i, 'value': i} for i in all_options[selected_graph]]

@app.callback(
    Output(component_id='travel_graph', component_property='figure'),
    [Input(component_id='slct_comparison_graph', component_property='value'),
     Input(component_id='target_radio', component_property='value')]
)
def update_graph(slct_comparison_graph_value, slct_graph_target):
    print(slct_comparison_graph_value)
    print(type(slct_comparison_graph_value))
    df = dfTravel

    df = df[df["eType"] == 6]
    title = "Travel channel"

    if len(slct_graph_target) > 0:
        df2 = df.copy()
        df = df[df["eType"] == -100]
        for target in slct_graph_target:
            df = df.append(df2[df2["Target"] == target])

    sourceIn = [str([x]) for x in df['Source']]
    targetIn = [str([x]) for x in df['Target']]
    sourceLocIn = [str(x) for x in df['SourceLocation']]
    weightIn = [abs(int(x)) for x in df['Weight']]
    fig = px.scatter(x=df["Time"]/(3600*24), y=sourceIn, color=sourceLocIn, symbol=targetIn,
                     size=weightIn, hover_data=[weightIn])
    fig.update_layout(height=600, margin={'l': 20, 'b': 30, 'r': 10, 't': 30})

    fig.update_layout(
        title="Selected Targets: " + str(slct_graph_target),
        yaxis_title="Source Id",
        xaxis_title="Time(days)",
        font=dict(
            family="Courier New, monospace",
            size=18,
            color="#000000"
        )
    )

    # container = "Upper Graph: Template | Lower Graph: {}".format(str(title))

    return fig


# ------------------------------------------------------------------------------
if __name__ == '__main__':
    app.run_server(debug=False)

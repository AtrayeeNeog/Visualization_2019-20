import dash
import dash_html_components as html
import dash_core_components as dcc
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

external_stylesheets = ['https://codepen.io/chriddyp/pen/bWLwgP.css']

app = dash.Dash(__name__, external_stylesheets=external_stylesheets)
app.layout = html.Div([
    dcc.Dropdown(
        id='demo-dropdown',
        options=[
            {'label': 'Template', 'value': 'Template'},
            {'label': 'Q1 Graph 1', 'value': 'Q1Graph1'},
            {'label': 'Q1 Graph 2', 'value': 'Q1Graph2'}
        ],
        value='NYC'
    ),
    html.Div(id='dd-output-container')
])


@app.callback(
    dash.dependencies.Output('dd-output-container', 'children'),
    [dash.dependencies.Input('demo-dropdown', 'value')])


def update_output(value):

    if value == "Template":
            return 'You have selected "{}"'.format(template)
    elif value == "Q1Graph1":
            return 'You have selected "{}"'.format(q1Graph1)
    elif value == "Q1Graph2":
            return 'You have selected "{}"'.format(q1Graph1)
    else:
        return "not available"


    return 'You have selected "{}"'.format(value)


if __name__ == '__main__':
    template = [1, 3, 5]
    q1Graph1 = [50, 60, 90]
    q1Graph2 = [300, 900, 700]


    app.run_server(debug=True)

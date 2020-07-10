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
    'template': list(dict.fromkeys(dfTemplate[dfTemplate['eType'] == 6]["Target"])),
    'q1graph1': list(dict.fromkeys(dfGraph1[dfGraph1['eType'] == 6]["Target"])),
    'q1graph2': list(dict.fromkeys(dfGraph2[dfGraph2['eType'] == 6]["Target"])),
    'q1graph3': list(dict.fromkeys(dfGraph3[dfGraph3['eType'] == 6]["Target"])),
    'q1graph4': list(dict.fromkeys(dfGraph4[dfGraph4['eType'] == 6]["Target"])),
    'q1graph5': list(dict.fromkeys(dfGraph5[dfGraph5['eType'] == 6]["Target"])),
    'q2graph1': list(dict.fromkeys(dfQ2Seed1[dfQ2Seed1['eType'] == 6]["Target"])),
    'q2graph3': list(dict.fromkeys(dfQ2Seed3[dfQ2Seed3['eType'] == 6]["Target"])),
    'q3graph1': list(dict.fromkeys(dfQ3Seed1[dfQ3Seed1['eType'] == 6]["Target"])),
    'q3graph2': list(dict.fromkeys(dfQ3Seed3[dfQ3Seed3['eType'] == 6]["Target"])),
    'test': list(dict.fromkeys(dfTemplate[dfTemplate['eType'] == 6]["Target"])),

}


# ------------------------------------------------------------------------------
# App layout
app.layout = html.Div([

    html.H1("Communication Channel", style={'text-align': 'center'}),






    html.Div(id='output_container', children=[]),
    html.Br(),
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
                         width='40%',
                         verticalAlign="right"
                     )
                     ),
        dcc.RadioItems(id="arc_radio1",
                       options=[
                            {"label": "Add Arc", "value": "True"},
                            {"label": "Only Points", "value": "False"}],
                       value='True',
                       style=dict(
                           width='40%',
                           verticalAlign="left"
                       )
                       ),
        # dcc.RadioItems(id="arc_radio1",
        #                style=dict(
        #                     width='40%',
        #                     verticalAlign="left"
        #                )
        #                ),
        # dcc.RadioItems(id='target_radio'),


    ]),

    dcc.Graph(id='template_graph', figure={}, config={'displayModeBar': False}),


    html.Div([
        dcc.Dropdown(id="slct_comparison_graph2",
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
                         width='40%',
                         verticalAlign="right"
                     )
                     ),
        dcc.RadioItems(id="arc_radio2",
                       options=[
                            {"label": "Add Arc", "value": "True"},
                            {"label": "Only Points", "value": "False"}],
                       value='True',
                       style=dict(
                           width='40%',
                           verticalAlign="left"
                       )
                       ),

    ]),

    dcc.Graph(id='comparison_graph', figure={}, config={'displayModeBar': False})




])


# ------------------------------------------------------------------------------
# Connect the Plotly graphs with Dash Components


@app.callback(
    [Output(component_id='output_container', component_property='children'),
     Output(component_id='template_graph', component_property='figure'),
     Output(component_id='comparison_graph', component_property='figure')],
    [Input(component_id='slct_comparison_graph', component_property='value'),
     Input(component_id='slct_comparison_graph2', component_property='value'),
     Input(component_id='arc_radio1', component_property='value'),
     Input(component_id='arc_radio2', component_property='value')]
)
def update_graph(slct_comparison_graph_value, slct_comparison_graph2_value, slct_arc1, slct_arc2):
    print(slct_comparison_graph_value)
    print(type(slct_comparison_graph_value))
    df = dfTemplate
    title = "Travel"
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

    # df = dfGraph2
    df_eT0People = list(df[df["eType"] == 0]["Source"]) + list(
        df[df["eType"] == 0]["Target"])
    df_eT1People = list(df[df["eType"] == 1]["Source"]) + list(
        df[df["eType"] == 1]["Target"])
    df_eT01People = list(dict.fromkeys(list(df_eT0People) + list(df_eT1People)))
    df_eT01People = [str(x) for x in df_eT01People]

    f = plt.figure(figsize=(20, 10))

    # adding a title for the whole graph
    f.suptitle('Time versus Source and Target for Template', fontsize=36)

    time0 = df[(df["eType"] == 0)]["Time"] / (24 * 3600)
    time1 = df[(df["eType"] == 1)]["Time"] / (24 * 3600)

    source0StringList = [str(x) for x in df[(df["eType"] == 0)]['Source']]
    target0StringList = [str(x) for x in df[(df["eType"] == 0)]['Target']]
    source0IndexList = [str([df_eT01People.index(i)]) for i in source0StringList]
    target0IndexList = [str([df_eT01People.index(i)]) for i in target0StringList]

    source1StringList = [str(x) for x in df[(df["eType"] == 1)]['Source']]
    target1StringList = [str(x) for x in df[(df["eType"] == 1)]['Target']]
    source1IndexList = [str([df_eT01People.index(i)]) for i in source1StringList]
    target1IndexList = [str([df_eT01People.index(i)]) for i in target1StringList]

    fig = go.Figure()

    fig.add_trace(go.Scatter(
        x=time0,
        y=source0IndexList,
        mode="markers",
        marker_color='rgba(44, 130, 201, 1)',
        name="Email Sender",
    ))

    fig.add_trace(go.Scatter(
        x=time0,
        y=target0IndexList,
        mode="markers",
        marker_color='rgba(137, 196, 244, 1)',
        name="Email Receiver",
    ))

    fig.add_trace(go.Scatter(
        x=time1,
        y=source1IndexList,
        mode="markers",
        marker_color='rgba(0, 177, 106, 1)',
        name="Caller",
    ))

    fig.add_trace(go.Scatter(
        x=time1,
        y=target1IndexList,
        mode="markers",
        marker_color='rgba(123, 239, 178, 1)',
        name="Call Receiver",
    ))

    fig.update_xaxes(
        range=[0, max(list(time0))],
        zeroline=False,
    )

    fig.update_yaxes(
        range=[-1, len(df_eT01People)],
        zeroline=False,
    )

    path1 = []
    for i in range(len(time0)):
        middlepart = str(
            (df_eT01People.index(source0StringList[i]) + df_eT01People.index(target0StringList[i])) / 2)
        nextStr = "M " + str(list(time0)[i]) + "," + str(
            df_eT01People.index(source0StringList[i])) + " Q " + str(
            list(time0)[i] + 2 * (float(middlepart) / 5)) + "," + middlepart + " " + str(
            list(time0)[i]) + "," + str(df_eT01People.index(target0StringList[i]))
        path1.append(nextStr)
    # print(path1)
    type1 = ["path"] * len(time0)
    # path1=[nextStr]
    line_color1 = ["RoyalBlue"] * len(time0)

    shapes1 = []
    # Quadratic Bezier Curves
    for i in range(len(time0)):
        shapes1.append(dict(
            type=type1[i],
            path=path1[i],
            line_color=line_color1[i], ),
        )

    path1 = []
    for i in range(len(time1)):
        middlepart = str(
            (df_eT01People.index(source1StringList[i]) + df_eT01People.index(target1StringList[i])) / 2)
        nextStr = "M " + str(list(time1)[i]) + "," + str(
            df_eT01People.index(source1StringList[i])) + " Q " + str(
            list(time1)[i] + 2 * (float(middlepart) / 5)) + "," + middlepart + " " + str(
            list(time1)[i]) + "," + str(
            df_eT01People.index(target1StringList[i]))
        path1.append(nextStr)
    # print(path1)
    type1 = ["path"] * len(time1)
    # path1=[nextStr]
    line_color1 = ["LightSeaGreen"] * len(time1)

    shapes2 = []
    # Quadratic Bezier Curves
    for i in range(len(time1)):
        shapes2.append(dict(
            type=type1[i],
            path=path1[i],
            line_color=line_color1[i], ),
        )

    if slct_arc1 == "True":
        fig.update_layout(
            shapes=shapes1 + shapes2
        )
    # shapes1.append(shapes2)
    fig.update_layout(
        yaxis=dict(
            autorange=True,
            showgrid=False,
            ticks="",
            showticklabels=False
        ),
        height=300,
        margin={'l': 20, 'b': 30, 'r': 10, 't': 20}
    )
    fig.update_xaxes(range=[0, 365])

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

    df_eT0People = list(df[df["eType"] == 0]["Source"]) + list(
        df[df["eType"] == 0]["Target"])
    df_eT1People = list(df[df["eType"] == 1]["Source"]) + list(
        df[df["eType"] == 1]["Target"])
    df_eT01People = list(dict.fromkeys(list(df_eT0People) + list(df_eT1People)))
    df_eT01People = [str(x) for x in df_eT01People]

    f = plt.figure(figsize=(20, 10))

    # adding a title for the whole graph
    f.suptitle('Time versus Source and Target for Template', fontsize=36)

    time0 = df[(df["eType"] == 0)]["Time"] / (24 * 3600)
    time1 = df[(df["eType"] == 1)]["Time"] / (24 * 3600)

    source0StringList = [str(x) for x in df[(df["eType"] == 0)]['Source']]
    target0StringList = [str(x) for x in df[(df["eType"] == 0)]['Target']]
    source0IndexList = [str([df_eT01People.index(i)]) for i in source0StringList]
    target0IndexList = [str([df_eT01People.index(i)]) for i in target0StringList]

    source1StringList = [str(x) for x in df[(df["eType"] == 1)]['Source']]
    target1StringList = [str(x) for x in df[(df["eType"] == 1)]['Target']]
    source1IndexList = [str([df_eT01People.index(i)]) for i in source1StringList]
    target1IndexList = [str([df_eT01People.index(i)]) for i in target1StringList]

    figT = go.Figure()

    figT.add_trace(go.Scatter(
        x=time0,
        y=source0IndexList,
        mode="markers",
        marker_color='rgba(44, 130, 201, 1)',
        name="Email Sender",
    ))

    figT.add_trace(go.Scatter(
        x=time0,
        y=target0IndexList,
        mode="markers",
        marker_color='rgba(137, 196, 244, 1)',
        name="Email Receiver",
    ))

    figT.add_trace(go.Scatter(
        x=time1,
        y=source1IndexList,
        mode="markers",
        marker_color='rgba(0, 177, 106, 1)',
        name="Caller",
    ))

    figT.add_trace(go.Scatter(
        x=time1,
        y=target1IndexList,
        mode="markers",
        marker_color='rgba(123, 239, 178, 1)',
        name="Call Receiver",
    ))

    figT.update_xaxes(
        range=[0, max(list(time0))],
        zeroline=False,
    )

    figT.update_yaxes(
        range=[-1, len(df_eT01People)],
        zeroline=False,
    )

    path1 = []
    for i in range(len(time0)):
        middlepart = str(
            (df_eT01People.index(source0StringList[i]) + df_eT01People.index(target0StringList[i])) / 2)
        nextStr = "M " + str(list(time0)[i]) + "," + str(
            df_eT01People.index(source0StringList[i])) + " Q " + str(
            list(time0)[i] + 2 * (float(middlepart) / 5)) + "," + middlepart + " " + str(
            list(time0)[i]) + "," + str(df_eT01People.index(target0StringList[i]))
        path1.append(nextStr)
    # print(path1)
    type1 = ["path"] * len(time0)
    # path1=[nextStr]
    line_color1 = ["RoyalBlue"] * len(time0)

    shapes1 = []
    # Quadratic Bezier Curves
    for i in range(len(time0)):
        shapes1.append(dict(
            type=type1[i],
            path=path1[i],
            line_color=line_color1[i], ),
        )

    path1 = []
    for i in range(len(time1)):
        middlepart = str(
            (df_eT01People.index(source1StringList[i]) + df_eT01People.index(target1StringList[i])) / 2)
        nextStr = "M " + str(list(time1)[i]) + "," + str(
            df_eT01People.index(source1StringList[i])) + " Q " + str(
            list(time1)[i] + 2 * (float(middlepart) / 5)) + "," + middlepart + " " + str(
            list(time1)[i]) + "," + str(
            df_eT01People.index(target1StringList[i]))
        path1.append(nextStr)
    # print(path1)
    type1 = ["path"] * len(time1)
    # path1=[nextStr]
    line_color1 = ["LightSeaGreen"] * len(time1)

    shapes2 = []
    # Quadratic Bezier Curves
    for i in range(len(time1)):
        shapes2.append(dict(
            type=type1[i],
            path=path1[i],
            line_color=line_color1[i], ),
        )

    # shapes1.append(shapes2)
    if slct_arc2 == "True":
        figT.update_layout(
            shapes=shapes1 + shapes2,
        )
    figT.update_layout(
        yaxis=dict(
            autorange=True,
            showgrid=False,
            ticks="",
            showticklabels=False
        ),
        height=300,
        margin={'l': 20, 'b': 30, 'r': 10, 't': 20}
    )
    figT.update_xaxes(range=[0, 365])


    container = "Upper Graph: Template | Lower Graph: {}".format(str(title))

    return container, fig, figT


# ------------------------------------------------------------------------------
if __name__ == '__main__':
    app.run_server(debug=False)

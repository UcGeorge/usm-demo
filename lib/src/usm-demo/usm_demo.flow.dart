import 'package:flutter/material.dart';
import 'package:flutter_assist/flutter_assist.dart';

import '../../app/streamed_value.dart';
import '../../app/types.dart';
import '../../util/alert.util.dart';
import 'services/bfs.service.dart';
import 'services/bibi.service.dart';
import 'services/dfs.service.dart';
import 'services/dls.service.dart';
import 'services/ids.service.dart';
import 'services/ucs.service.dart';
import 'weight/weight.view.dart';

class UsmDemoFlow {
  UsmDemoFlow() {
    LogUtil.devLog("HomeFlow", message: "New Instance");
  }

  static List<Vertex> verticesLabels = [
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
    "L",
    "M",
    "N",
    "O",
    "P",
    "Q",
    "R",
    "S",
    "T",
    "U",
    "V",
    "W",
    "X",
    "Y",
    "Z"
  ];

  StreamedValue<bool> canReset = StreamedValue<bool>(initialValue: false);
  final StreamedValue<CostMap> costs = StreamedValue<CostMap>(initialValue: {});
  final StreamedValue<int> depthLimit = StreamedValue<int>(initialValue: 0);
  StreamedValue<bool> directed = StreamedValue<bool>(initialValue: false);
  final Map<VertexPair, Color> edgeColorMap = {};
  StreamedValue<Vertex?> goal = StreamedValue<Vertex?>(initialValue: null);
  final StreamedValue<Graph> graph = StreamedValue<Graph>(initialValue: {});
  final StreamedValue<VertexPositionMap> positions =
      StreamedValue<VertexPositionMap>(initialValue: {});

  StreamedValue<Vertex?> root = StreamedValue<Vertex?>(initialValue: null);
  final StreamedValue<Usm> searchMethod =
      StreamedValue<Usm>(initialValue: Usm.bfs);

  final StreamedValue<Vertex?> selectedVertex =
      StreamedValue<Vertex?>(initialValue: null);

  int vIndex = 0;
  final Map<Vertex, Color> vertexColorMap = {};
  StreamedValue<bool> weighted = StreamedValue<bool>(initialValue: false);

  void createVertex(Offset position) async {
    if (vIndex >= 26) return;

    final vertex = verticesLabels[vIndex++];

    vertexColorMap[vertex] = Colors.black;

    positions.mutate((state) => state.putIfAbsent(vertex, () => position));
    graph.mutate((state) => state.putIfAbsent(vertex, () => <String>{}));
  }

  void moveVertex(Offset position, Vertex vertex) {
    positions.mutate(
      (state) => state.update(
        vertex,
        (oldPosition) => position,
        ifAbsent: () => position,
      ),
    );
    graph.mutate((state) => state);
  }

  void createEdge(Vertex vertex, BuildContext context) async {
    final sVertex = selectedVertex.value;

    if (sVertex == null) {
      selectedVertex.update(vertex);
      return;
    }

    if (sVertex == vertex) {
      selectedVertex.update(null);
      return;
    }

    int? weight;

    if (weighted.value) {
      weight = await FlowUtil.moveTo<int>(
        context: context,
        barrierColor: Colors.black.withOpacity(.15),
        opaque: false,
        transition: FlowTransition.scale,
        page: WeightView(),
      );

      if (weight == null) return;

      costs.mutate((state) {
        state.update(
          "$sVertex-$vertex",
          (value) => weight!.toDouble(),
          ifAbsent: () => weight!.toDouble(),
        );
        if (!directed.value) {
          state.update(
            "$vertex-$sVertex",
            (value) => weight!.toDouble(),
            ifAbsent: () => weight!.toDouble(),
          );
        }
      });
    }

    edgeColorMap["$sVertex-$vertex"] = Colors.black;
    if (!directed.value) {
      edgeColorMap["$vertex-$sVertex"] = Colors.black;
    }

    graph.mutate((state) {
      state.update(sVertex, (value) => value..add(vertex));
      if (!directed.value) {
        state.update(vertex, (value) => value..add(sVertex));
      }
    });

    selectedVertex.update(null);
  }

  void clearGraph() {
    vIndex = 0;
    selectedVertex.update(null);
    costs.update({});
    root.update(null);
    goal.update(null);
    graph.update({});
    positions.update({});
    vertexColorMap.clear();
    edgeColorMap.clear();
  }

  void clearEdges() {
    graph.mutate((state) => state..updateAll((key, value) => value..clear()));
    edgeColorMap.clear();
  }

  void resetGraph() {
    vertexColorMap.updateAll((key, value) => Colors.black);
    edgeColorMap.updateAll((key, value) => Colors.black);
    graph.mutate((state) => state);
    canReset.update(false);
  }

  Future<void> startMethod() async {
    if (canReset.value) {
      AlertUtil.showWarning("Please reset the graph.");
      return;
    }

    if (root.value == null || goal.value == null) {
      AlertUtil.showWarning("Please select both a root and goal node.");
      return;
    }

    switch (searchMethod.value) {
      case Usm.bfs:
        final path = await BfsService.start(
          graph: graph.value,
          goal: goal.value!,
          root: root.value!,
          drawPath: (p0, p1) => _drawPath(path: p0, color: p1),
        );
        canReset.update(true);
        break;

      case Usm.dfs:
        final path = await DfsService.start(
          graph: graph.value,
          goal: goal.value!,
          root: root.value!,
          drawPath: (p0, p1) => _drawPath(path: p0, color: p1),
        );
        canReset.update(true);
        break;

      case Usm.dls:
        final path = await DlsService.start(
          graph: graph.value,
          goal: goal.value!,
          root: root.value!,
          depthLimit: depthLimit.value,
          drawPath: (p0, p1) => _drawPath(path: p0, color: p1),
        );
        canReset.update(true);
        break;

      case Usm.ids:
        final path = await IdsService.start(
          graph: graph.value,
          goal: goal.value!,
          root: root.value!,
          depthLimit: depthLimit.value,
          resetGraph: resetGraph,
          drawPath: (p0, p1) => _drawPath(path: p0, color: p1),
        );
        canReset.update(true);
        break;

      case Usm.bidi:
        final path = await BidiService.start(
          graph: graph.value,
          goal: goal.value!,
          root: root.value!,
          depthLimit: depthLimit.value,
          drawPath: (p0, p1) => _drawPath(path: p0, color: p1),
        );
        canReset.update(true);
        break;

      case Usm.ucs:
        final path = await UcsService.start(
          graph: graph.value,
          goal: goal.value!,
          root: root.value!,
          edgeCosts: costs.value,
          drawPath: (p0, p1) => _drawPath(path: p0, color: p1),
        );
        canReset.update(true);
        break;
    }
  }

  void _drawPath({required Path path, Color color = Colors.black}) {
    var start = path[0];

    for (int i = 1; i < path.length; i++) {
      var end = path[i];

      vertexColorMap[start] = color;
      vertexColorMap[end] = color;
      edgeColorMap["$start-$end"] = color;
      if (!directed.value) {
        edgeColorMap["$end-$start"] = color;
      }
      start = end;

      graph.mutate((state) => state);
    }
  }
}

enum Usm { bfs, dfs, dls, ids, bidi, ucs }

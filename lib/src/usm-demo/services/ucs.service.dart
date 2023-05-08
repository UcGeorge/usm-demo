import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../app/priority_queue.dart';
import '../../../app/types.dart';

class UcsService {
  static Future<Path?> start({
    required Graph graph,
    required Vertex root,
    required Vertex goal,
    required CostMap edgeCosts,
    Duration? pauseDuration,
    void Function(Path, Color)? drawPath,
  }) async {
    PriorityQueue<MapEntry<double, Vertex>> frontier =
        PriorityQueue<MapEntry<double, Vertex>>(
            (a, b) => a.key.compareTo(b.key));
    frontier.add(MapEntry(0, root));

    Set<Vertex> visited = {};
    PathMap paths = {for (var v in graph.keys) v: null};
    CostMap costs = {for (var v in graph.keys) v: double.infinity};
    costs[root] = 0;

    while (!frontier.isEmpty) {
      MapEntry<double, Vertex> currentEntry = frontier.removeFirst();

      double currentCost = currentEntry.key;
      Vertex currentVertex = currentEntry.value;

      List<Vertex> nodePath = _composePath(currentVertex, paths);

      // Draw the path
      drawPath?.call(nodePath, Colors.orange);
      await Future.delayed(pauseDuration ?? 300.ms);

      if (currentVertex == goal) {
        // Draw the path
        drawPath?.call(nodePath, Colors.green);
        return nodePath;
      }

      visited.add(currentVertex);

      for (Vertex neighbor in graph[currentVertex]!) {
        double cost = currentCost + edgeCosts['$currentVertex-$neighbor']!;

        // Draw the path
        drawPath?.call([currentVertex, neighbor], Colors.yellow);
        await Future.delayed(pauseDuration ?? 150.ms);

        if (!visited.contains(neighbor) || cost < costs[neighbor]!) {
          costs[neighbor] = cost;
          paths[neighbor] = currentVertex;

          frontier.add(MapEntry(cost, neighbor));
        }
      }
      await Future.delayed(pauseDuration ?? 1000.ms);
    }

    return [];
  }

  static List<Vertex> _composePath(Vertex? vertex, PathMap paths) {
    List<Vertex> path = [];
    while (vertex != null) {
      path.insert(0, vertex);
      vertex = paths[vertex];
    }
    return path;
  }
}

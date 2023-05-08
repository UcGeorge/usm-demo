import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../app/types.dart';

class DlsService {
  static Future<Path?> start({
    required Graph graph,
    required Vertex root,
    required Vertex goal,
    required int depthLimit,
    Duration? pauseDuration,
    void Function(Path, Color)? drawPath,
  }) async {
    List<Vertex> stack = [root];
    Set<Vertex> visited = {};
    PathMap paths = {for (var v in graph.keys) v: null};
    DepthMap depths = {root: 0};

    while (stack.isNotEmpty) {
      // Remove Vertex from the queue
      Vertex vertex = stack.removeAt(stack.length - 1);

      // This Vertex has not been explored
      if (!visited.contains(vertex)) {
        // Add Vertex to the list of visited vertices
        visited.add(vertex);

        List<Vertex> nodePath = _composePath(vertex, paths);

        // Draw the path
        drawPath?.call(nodePath, Colors.orange);
        await Future.delayed(pauseDuration ?? 300.ms);

        // Vertex is the goal
        if (vertex == goal) {
          // Draw the path
          drawPath?.call(nodePath, Colors.green);

          // Return the path to the vertex
          return nodePath;
        }

        // Vertex is at the depth limit
        if (depths[vertex]! >= depthLimit) continue;

        // Add all adjacent vertices that have not been visited to queue
        Set<Vertex> adjacentVertices =
            graph[vertex]!.difference(visited).difference(Set.from(stack));
        stack.addAll(adjacentVertices);

        for (var v in adjacentVertices) {
          paths[v] = vertex;
          depths[v] = depths[vertex]! + 1;
        }
      }
    }

    return null;
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

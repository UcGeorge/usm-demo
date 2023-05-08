import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../app/types.dart';

class BidiService {
  static Future<Path?> start({
    required Graph graph,
    required Vertex root,
    required Vertex goal,
    required int depthLimit,
    Duration? pauseDuration,
    void Function(Path, Color)? drawPath,
  }) async {
    List<Vertex> rootQueue = [root];
    List<Vertex> goalQueue = [goal];
    Set<Vertex> rootVisited = {};
    Set<Vertex> goalVisited = {};
    PathMap paths = {for (var v in graph.keys) v: null};

    while (rootQueue.isNotEmpty || goalQueue.isNotEmpty) {
      if (rootQueue.isNotEmpty) {
        // Remove Vertex from the queue
        Vertex vertex = rootQueue.removeAt(0);

        // This Vertex has not been explored
        if (!rootVisited.contains(vertex)) {
          // Add Vertex to the list of rootVisited vertices
          rootVisited.add(vertex);

          List<Vertex> nodePath = _composePath(vertex, paths);

          // Draw the path
          drawPath?.call(nodePath, Colors.orange);
          await Future.delayed(pauseDuration ?? 300.ms);

          // Vertex is the goal
          if (vertex == goal) {
            // Return the path to the vertex
            return _composePath(vertex, paths);
          }

          // Add all adjacent vertices that have not been rootVisited to rootQueue
          Set<Vertex> adjacentVertices = graph[vertex]!
              .difference(rootVisited)
              .difference(Set.from(rootQueue));
          rootQueue.addAll(adjacentVertices);

          for (var v in adjacentVertices) {
            // Vertex has been seen
            if (paths[v] != null) {
              List<Vertex> pathToGoal =
                  _composePath(v, paths).reversed.toList();

              // Return the node path to goal
              nodePath.addAll(pathToGoal);

              drawPath?.call(nodePath, Colors.green);

              // Return the path to the goal
              return nodePath;
            }

            // Vertex has not been seen
            paths[v] = vertex;
          }
        }
      }

      if (goalQueue.isNotEmpty) {
        // Remove Vertex from the queue
        Vertex vertex = goalQueue.removeAt(0);

        // This Vertex has not been explored
        if (!goalVisited.contains(vertex)) {
          // Add Vertex to the list of goalVisited vertices
          goalVisited.add(vertex);

          List<Vertex> nodePath = _composePath(vertex, paths);

          // Draw the path
          drawPath?.call(nodePath, Colors.orange);
          await Future.delayed(pauseDuration ?? 300.ms);

          // Vertex is the root
          if (vertex == root) {
            // Return the path to the vertex
            return _composePath(vertex, paths);
          }

          // Add all adjacent vertices that have not been goalVisited to goalQueue
          Set<Vertex> adjacentVertices = graph[vertex]!
              .difference(goalVisited)
              .difference(Set.from(goalQueue));
          goalQueue.addAll(adjacentVertices);

          for (var v in adjacentVertices) {
            // Vertex has been seen
            if (paths[v] != null) {
              List<Vertex> pathFromRoot = _composePath(v, paths);

              // Return the node path to goal
              pathFromRoot.addAll(nodePath.reversed.toList());

              drawPath?.call(pathFromRoot, Colors.green);

              // Return the path to the goal
              return pathFromRoot;
            }

            // Vertex has not been seen
            paths[v] = vertex;
          }
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

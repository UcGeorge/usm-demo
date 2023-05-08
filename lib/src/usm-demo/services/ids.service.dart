import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../app/types.dart';
import 'dls.service.dart';

class IdsService {
  static Future<Path?> start({
    required Graph graph,
    required Vertex root,
    required Vertex goal,
    required int depthLimit,
    Duration? pauseDuration,
    void Function(Path, Color)? drawPath,
    void Function()? resetGraph,
  }) async {
    for (int i = 1; i <= depthLimit; i++) {
      resetGraph?.call();
      final path = await DlsService.start(
        graph: graph,
        root: root,
        goal: goal,
        depthLimit: i,
        drawPath: drawPath,
        pauseDuration: pauseDuration,
      );
      await Future.delayed(pauseDuration ?? 300.ms);
      if (path != null) return path;
    }
    return null;
  }
}

import 'package:flutter/material.dart';

import '../../../app/colors.dart';
import '../../../app/fonts.dart';
import '../../../app/types.dart';
import '../usm_demo.flow.dart';
import 'graph.dart';

class VertexLayer extends StatelessWidget {
  const VertexLayer({
    super.key,
    required this.offset,
    required this.vertex,
    required this.flow,
  });

  final UsmDemoFlow flow;
  final Offset offset;
  final Vertex vertex;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: offset.dy - vertexRadius,
      left: offset.dx - vertexRadius,
      child: StreamBuilder<Vertex?>(
        stream: flow.selectedVertex.stream,
        initialData: flow.selectedVertex.value,
        builder: (context, snapshot) {
          final selectedVertex = snapshot.data;
          return InkWell(
            borderRadius: BorderRadius.circular(vertexRadius),
            onDoubleTap: () => flow.createEdge(vertex, context),
            child: GestureDetector(
              onVerticalDragUpdate: (details) =>
                  flow.moveVertex(details.globalPosition, vertex),
              onHorizontalDragUpdate: (details) =>
                  flow.moveVertex(details.globalPosition, vertex),
              child: StreamBuilder<Vertex?>(
                stream: flow.root.stream,
                initialData: flow.root.value,
                builder: (context, rootSnapshot) {
                  final root = rootSnapshot.data;
                  return StreamBuilder<Vertex?>(
                    stream: flow.goal.stream,
                    initialData: flow.goal.value,
                    builder: (context, goalSnapshot) {
                      final goal = goalSnapshot.data;
                      return CircleAvatar(
                        radius: vertexRadius,
                        backgroundColor: () {
                          if (vertex == selectedVertex) return Colors.blue;
                          if (vertex == root) return Colors.red;
                          if (vertex == goal) return Colors.green;
                          return flow.vertexColorMap[vertex];
                        }.call(),
                        child: Text(
                          vertex,
                          style: AppFonts.nunito.copyWith(
                            fontSize: 24,
                            color: AppColors.white,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

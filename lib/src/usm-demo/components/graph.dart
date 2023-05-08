import 'package:flutter/material.dart';

import '../../../app/types.dart';
import '../usm_demo.flow.dart';
import 'edge_layer.dart';
import 'vertex_layer.dart';

const double vertexRadius = 24;

class GraphWidget extends StatefulWidget {
  const GraphWidget({
    super.key,
    required this.flow,
  });

  final UsmDemoFlow flow;

  @override
  State<GraphWidget> createState() => _GraphWidgetState();
}

class _GraphWidgetState extends State<GraphWidget> {
  Offset? newVertexOffset;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return GestureDetector(
        onDoubleTap: () => widget.flow.createVertex(newVertexOffset!),
        onDoubleTapDown: (details) => newVertexOffset = details.localPosition,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(.11),
            image: const DecorationImage(
              image: AssetImage("assets/images/graph-bg.png"),
              opacity: .3,
              repeat: ImageRepeat.repeat,
            ),
          ),
          child: SizedBox(
            height: constraints.maxHeight,
            width: constraints.maxWidth,
            child: StreamBuilder<Graph>(
              stream: widget.flow.graph.stream,
              initialData: widget.flow.graph.value,
              builder: (context, snapshot) {
                final graph = snapshot.data!;

                final List<Widget> vertices = [];
                final List<Widget> edges = [];

                for (Vertex g in graph.keys) {
                  final start = widget.flow.positions.value[g]!;

                  var v = VertexLayer(
                    offset: start,
                    vertex: g,
                    flow: widget.flow,
                  );

                  vertices.add(v);

                  for (Vertex e in graph[g]!) {
                    final end = widget.flow.positions.value[e]!;

                    var v = EdgeLayer(
                      weight: widget.flow.weighted.value
                          ? widget.flow.costs.value["$g-$e"]
                          : null,
                      directed: widget.flow.directed.value,
                      color: widget.flow.edgeColorMap["$g-$e"] ?? Colors.black,
                      size: Size(
                        constraints.maxWidth,
                        constraints.maxHeight,
                      ),
                      start: start,
                      end: end,
                    );

                    edges.add(v);
                  }
                }

                return Stack(
                  children: [
                    ...edges,
                    ...vertices,
                  ],
                );
              },
            ),
          ),
        ),
      );
    });
  }
}

import 'package:flutter/material.dart';

import '../../../../app/fonts.dart';
import '../../usm_demo.flow.dart';

class MethodSelector extends StatelessWidget {
  const MethodSelector({
    super.key,
    required this.flow,
  });

  final UsmDemoFlow flow;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Usm>(
        stream: flow.searchMethod.stream,
        initialData: flow.searchMethod.value,
        builder: (context, snapshot) {
          final searchMethod = snapshot.data!;
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: DropdownButton<Usm>(
                value: searchMethod,
                hint: const Text("Select search method"),
                alignment: Alignment.center,
                dropdownColor: Colors.white,
                borderRadius: BorderRadius.circular(10),
                underline: const SizedBox.shrink(),
                style: AppFonts.nunito.copyWith(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
                items: Usm.values.map((e) {
                  return DropdownMenuItem<Usm>(
                    value: e,
                    child: Text(() {
                      switch (e) {
                        case Usm.bfs:
                          return "Breath-First Search (BFS)";
                        case Usm.dfs:
                          return "Depth-First Search (DFS)";
                        case Usm.dls:
                          return "Depth-Limited Search (DLS)";
                        case Usm.ids:
                          return "Iterative Deepening Search (IDS)";
                        case Usm.bidi:
                          return "Bidirectional Search (BIDI)";
                        case Usm.ucs:
                          return "Uniform-Cost Search (UCS)";
                      }
                    }.call()),
                  );
                }).toList(),
                onChanged: (newState) =>
                    flow.searchMethod.update(newState ?? Usm.bfs),
              ),
            ),
          );
        });
  }
}

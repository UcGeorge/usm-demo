import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../app/fonts.dart';
import '../../../../app/types.dart';
import '../../usm_demo.flow.dart';

class RootGoalSelector extends StatelessWidget {
  const RootGoalSelector({
    super.key,
    required this.flow,
  });

  final UsmDemoFlow flow;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Graph>(
      stream: flow.graph.stream,
      initialData: flow.graph.value,
      builder: (context, snapshot) {
        final graph = snapshot.data!;
        return Row(
          children: [
            StreamBuilder<Vertex?>(
              stream: flow.root.stream,
              initialData: flow.root.value,
              builder: (context, rootSnapshot) {
                final root = rootSnapshot.data;
                return Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: DropdownButton<Vertex?>(
                        value: root,
                        hint: const Text("[ROOT]"),
                        alignment: Alignment.center,
                        dropdownColor: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        underline: const SizedBox.shrink(),
                        style: AppFonts.nunito.copyWith(
                          fontSize: 24,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                        items: graph.keys.map((e) {
                          return DropdownMenuItem<Vertex>(
                            value: e,
                            child: Text(e),
                          );
                        }).toList(),
                        onChanged: (newState) => flow.root.update(newState),
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(width: 8),
            const Icon(Iconsax.arrow_right_1),
            const SizedBox(width: 8),
            StreamBuilder<Vertex?>(
              stream: flow.goal.stream,
              initialData: flow.goal.value,
              builder: (context, goalSnapshot) {
                final goal = goalSnapshot.data;
                return Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: DropdownButton<Vertex?>(
                        value: goal,
                        hint: const Text("[GOAL]"),
                        alignment: Alignment.center,
                        dropdownColor: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        underline: const SizedBox.shrink(),
                        style: AppFonts.nunito.copyWith(
                          fontSize: 24,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                        items: graph.keys.map((e) {
                          return DropdownMenuItem<Vertex>(
                            value: e,
                            child: Text(e),
                          );
                        }).toList(),
                        onChanged: (newState) => flow.goal.update(newState),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}

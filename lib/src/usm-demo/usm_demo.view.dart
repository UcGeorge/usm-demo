import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:scaled_app/scaled_app.dart';

import '../../app/colors.dart';
import 'control/control.dart';
import 'components/graph.dart';
import 'usm_demo.flow.dart';

class UsmDemoView extends StatelessWidget {
  const UsmDemoView({super.key, required this.flow});

  final UsmDemoFlow flow;

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).scale(),
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: LayoutBuilder(builder: (context, c) {
          return SizedBox(
            width: c.maxWidth,
            height: c.maxHeight,
            child: Stack(
              children: [
                SizedBox(
                  width: c.maxWidth,
                  height: c.maxHeight,
                  child: GraphWidget(flow: flow),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: ControlCenter(flow: flow)
                      .animate()
                      .scaleXY(delay: 300.ms, duration: 150.ms),
                ),
              ],
            ),
          ).animate().fadeIn(duration: 300.ms);
        }),
      ),
    );
  }
}

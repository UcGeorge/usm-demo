import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_assist/flutter_assist.dart';
import 'package:scaled_app/scaled_app.dart';

import '../../../app/streamed_value.dart';
import 'components/weight.dart';

class WeightView extends StatelessWidget {
  WeightView({
    super.key,
  });

  final StreamedValue<int> weight = StreamedValue<int>(initialValue: 1);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return MediaQuery(
        data: MediaQuery.of(context).scale(),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.green[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: WeightWidget(weight: weight),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(24),
                      onTap: () => FlowUtil.back(context: context),
                      child: const CircleAvatar(
                        backgroundColor: Colors.red,
                        radius: 24,
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    InkWell(
                      borderRadius: BorderRadius.circular(24),
                      onTap: () => FlowUtil.back(
                        context: context,
                        result: weight.value,
                      ),
                      child: const CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 24,
                        child: Icon(
                          Icons.check,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ]
                      .animate(delay: 150.ms, interval: 150.ms)
                      .scaleXY(duration: 300.ms),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

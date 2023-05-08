import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax/iconsax.dart';

import '../../../app/colors.dart';
import '../../../app/fonts.dart';
import '../usm_demo.flow.dart';
import 'components/depth_limit.dart';
import 'components/method_selector.dart';
import 'components/play_button.dart';
import 'components/root_goal.dart';
import 'components/widgets.dart';

class ControlCenter extends StatefulWidget {
  const ControlCenter({
    super.key,
    required this.flow,
  });

  final UsmDemoFlow flow;

  @override
  State<ControlCenter> createState() => ControlCenterState();
}

class ControlCenterState extends State<ControlCenter> {
  bool expanded = true;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: 150.ms,
      curve: Curves.easeInOutCubic,
      height: expanded ? 600 : 96,
      width: expanded ? 480 : 96,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      margin: const EdgeInsets.all(24),
      padding: expanded ? const EdgeInsets.all(24) : EdgeInsets.zero,
      child: expanded
          ? SizedBox.expand(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Iconsax.setting_4,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          "Control center",
                          style: AppFonts.poppins.copyWith(
                            fontSize: 16,
                            color: AppColors.primaryBlue,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () => setState(() => expanded = !expanded),
                          child: Container(
                            color: Colors.transparent,
                            padding: const EdgeInsets.all(8.0),
                            child: const Icon(Iconsax.minus),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    buildGraphStats(),
                    const SizedBox(height: 16),
                    buildGraphTypeOptions(),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.green[200],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          RootGoalSelector(flow: widget.flow),
                          const SizedBox(height: 16),
                          MethodSelector(flow: widget.flow),
                          DepthLimitWidget(flow: widget.flow),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildResetButton(),
                        const SizedBox(width: 16),
                        PlayButton(flow: widget.flow),
                        const SizedBox(width: 16),
                        buildClearGraphButton(),
                      ],
                    ),
                  ],
                ),
              ),
            ).animate().fadeIn(delay: 150.ms)
          : InkWell(
              borderRadius: BorderRadius.circular(24),
              onTap:
                  expanded ? null : () => setState(() => expanded = !expanded),
              child: const Center(
                child: Icon(
                  Iconsax.setting_45,
                  size: 48,
                ),
              ),
            ),
    );
  }
}

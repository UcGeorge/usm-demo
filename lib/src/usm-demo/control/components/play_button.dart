import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../app/colors.dart';
import '../../../../app/fonts.dart';
import '../../../../app/types.dart';
import '../../../../util/alert.util.dart';
import '../../usm_demo.flow.dart';

class PlayButton extends StatefulWidget {
  const PlayButton({
    super.key,
    required this.flow,
  });

  final UsmDemoFlow flow;

  @override
  State<PlayButton> createState() => _PlayButtonState();
}

class _PlayButtonState extends State<PlayButton> {
  bool disabled = true;
  late StreamSubscription graphListener;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    _graphEventHandler(widget.flow.graph.value);
    graphListener = widget.flow.graph.stream.listen(_graphEventHandler);
  }

  void _graphEventHandler(Graph event) {
    final graphLength = event.length;

    if (graphLength > 0) {
      setState(() {
        disabled = false;
      });
    } else {
      setState(() {
        disabled = true;
      });
    }
  }

  void _start() {
    setState(() {
      loading = true;
    });
    widget.flow.startMethod().then(
          (value) => setState(
            () {
              loading = false;
            },
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(disabled ? .5 : 1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          loading
              ? const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Center(child: CupertinoActivityIndicator()),
                )
              : InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: disabled ? null : _start,
                  child: Container(
                    height: 52,
                    color: Colors.transparent,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Iconsax.play,
                          color: Colors.white,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "Start",
                          style: AppFonts.poppins.copyWith(
                            fontSize: 16,
                            color: AppColors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
          Container(
            color: Colors.white.withOpacity(.5),
            height: 52,
            width: 1,
          ),
          InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: disabled
                ? null
                : () {
                    AlertUtil.showWarning(
                        "Step-through feature is coming soon!");
                  },
            child: Container(
              height: 52,
              color: Colors.transparent,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: const Icon(
                Iconsax.next,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

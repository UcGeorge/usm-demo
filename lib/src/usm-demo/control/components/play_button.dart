import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:uninformed_search_demo/src/usm-demo/usm_demo.flow.dart';

import '../../../../app/colors.dart';
import '../../../../app/fonts.dart';

class PlayButton extends StatelessWidget {
  const PlayButton({
    super.key,
    required this.flow,
  });

  final UsmDemoFlow flow;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () {
              // TODO: Do something
            },
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
            onTap: () {
              // TODO: Do something
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

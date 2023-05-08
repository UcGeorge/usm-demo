import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../app/fonts.dart';
import '../../usm_demo.flow.dart';

class DepthLimitWidget extends StatelessWidget {
  const DepthLimitWidget({
    super.key,
    required this.flow,
  });

  final UsmDemoFlow flow;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: flow.depthLimit.stream,
      initialData: flow.depthLimit.value,
      builder: (context, depthSnapshot) {
        final depthLimit = depthSnapshot.data!;
        return StreamBuilder<Usm>(
          stream: flow.searchMethod.stream,
          initialData: flow.searchMethod.value,
          builder: (context, sms) {
            final searchMethod = sms.data!;
            return searchMethod == Usm.dls || searchMethod == Usm.ids
                ? Container(
                    margin: const EdgeInsets.only(top: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(width: 16, height: 48),
                        Text(
                          "Depth limit",
                          style: AppFonts.nunito.copyWith(
                            fontSize: 24,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 16, height: 48),
                        Container(
                          color: Colors.grey,
                          height: 48,
                          width: 1,
                        ),
                        InkWell(
                          onTap: () => flow.depthLimit.update((depthLimit - 1)
                              .clamp(0, flow.graph.value.length)),
                          child: Container(
                            height: 48,
                            color: Colors.transparent,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                            ),
                            child: const Icon(Iconsax.minus),
                          ),
                        ),
                        Container(
                          color: Colors.grey,
                          height: 48,
                          width: 1,
                        ),
                        SizedBox(
                          height: 48,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                            ),
                            child: Center(
                              child: Text(
                                depthLimit.toString(),
                                style: AppFonts.nunito.copyWith(
                                  fontSize: 24,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          color: Colors.grey,
                          height: 48,
                          width: 1,
                        ),
                        InkWell(
                          onTap: () => flow.depthLimit.update((depthLimit + 1)
                              .clamp(0, flow.graph.value.length)),
                          child: Container(
                            height: 48,
                            color: Colors.transparent,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                            ),
                            child: const Icon(Iconsax.add),
                          ),
                        ),
                      ],
                    ),
                  )
                : const SizedBox.shrink();
          },
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../app/fonts.dart';
import '../../../../app/streamed_value.dart';

class WeightWidget extends StatelessWidget {
  const WeightWidget({
    super.key,
    required this.weight,
  });

  final StreamedValue<int> weight;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: weight.stream,
      initialData: weight.value,
      builder: (context, depthSnapshot) {
        final depthLimit = depthSnapshot.data!;
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(width: 16, height: 48),
              Text(
                "Edge Cost",
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
                onTap: () => weight.update((depthLimit - 1).clamp(-999, 999)),
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
                onTap: () => weight.update((depthLimit + 1).clamp(-999, 999)),
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
        );
      },
    );
  }
}

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../app/colors.dart';
import '../../../../app/fonts.dart';
import '../../../../app/types.dart';
import '../../usm_demo.flow.dart';
import '../control.dart';

extension ControlWidgets on ControlCenterState {
  Container buildGraphStats() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.blue.withOpacity(.15),
        //     offset: const Offset(0, 12),
        //     blurRadius: 16,
        //   ),
        // ],
      ),
      child: StreamBuilder<Graph>(
        stream: widget.flow.graph.stream,
        initialData: widget.flow.graph.value,
        builder: (context, snapshot) {
          final graph = snapshot.data!;
          return Row(
            children: [
              const SizedBox(width: 12),
              Expanded(
                child: Center(
                  child: Text.rich(
                    TextSpan(
                      text: graph.length.toString(),
                      style: AppFonts.sora.copyWith(
                        fontSize: 32,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(
                          text: "  Vertices",
                          style: AppFonts.nunito.copyWith(
                            fontSize: 18,
                            color: Colors.white.withOpacity(.5),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              DottedLine(
                lineLength: 64,
                direction: Axis.vertical,
                dashColor: Colors.white.withOpacity(.3),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Center(
                  child: Text.rich(
                    TextSpan(
                      text: widget.flow.edgeColorMap.length.toString(),
                      style: AppFonts.sora.copyWith(
                        fontSize: 32,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      children: [
                        TextSpan(
                          text: "  Edges",
                          style: AppFonts.nunito.copyWith(
                            fontSize: 18,
                            color: Colors.white.withOpacity(.5),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
            ],
          );
        },
      ),
    );
  }

  SizedBox buildClearGraphButton() {
    return SizedBox(
      height: 52,
      child: ElevatedButton(
        onPressed: widget.flow.clearGraph,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: AppColors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Iconsax.trash),
            const SizedBox(width: 8),
            Text(
              "Clear graph",
              style: AppFonts.poppins.copyWith(
                fontSize: 16,
                color: AppColors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildGraphTypeOptions() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          StreamBuilder<bool>(
            stream: widget.flow.directed.stream,
            initialData: widget.flow.directed.value,
            builder: (context, snapshot) {
              final directed = snapshot.data!;
              return Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Radio(
                      value: true,
                      toggleable: true,
                      groupValue: directed,
                      onChanged: (val) {
                        widget.flow.clearEdges();
                        widget.flow.directed.update(val ?? false);
                      },
                    ),
                    Text(
                      "Directed",
                      style: AppFonts.poppins.copyWith(
                        fontSize: 16,
                        color: AppColors.primaryBlue,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(width: 12),
          DottedLine(
            lineLength: 24,
            direction: Axis.vertical,
            dashColor: Colors.black.withOpacity(.3),
          ),
          const SizedBox(width: 12),
          StreamBuilder<bool>(
            stream: widget.flow.weighted.stream,
            initialData: widget.flow.weighted.value,
            builder: (context, snapshot) {
              final weighted = snapshot.data!;
              return Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Radio(
                      value: true,
                      toggleable: true,
                      groupValue: weighted,
                      onChanged: (val) {
                        if (widget.flow.searchMethod.value != Usm.ucs) {
                          widget.flow.clearEdges();
                          widget.flow.weighted.update(val ?? false);
                        }
                      },
                    ),
                    Text(
                      "Weighted",
                      style: AppFonts.poppins.copyWith(
                        fontSize: 16,
                        color: AppColors.primaryBlue,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  StreamBuilder<bool> buildResetButton() {
    return StreamBuilder<bool>(
      stream: widget.flow.canReset.stream,
      initialData: widget.flow.canReset.value,
      builder: (context, snapshot) {
        final canReset = snapshot.data!;
        return canReset
            ? InkWell(
                onTap: widget.flow.resetGraph,
                child: Container(
                  height: 52,
                  width: 52,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Icon(
                      Iconsax.refresh,
                      color: Colors.white,
                    ),
                  ),
                ),
              ).animate().fadeIn()
            : const SizedBox.shrink();
      },
    );
  }
}


import 'package:flutter/material.dart';
import 'package:libms_flutter/domain/constants.dart';
import 'package:libms_flutter/ui/bottom_nav_bar/bottom_nav_bar.dart';

class LoadMoreButton extends StatelessWidget {
  const LoadMoreButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: () {
          kGoToNextAndRemove(
              context,
              const BottomNavBar(
                index: 2,
              ));
        },
        child: Container(
          width: 120,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
              color: const Color(0xFF5AE4A8),
              borderRadius: BorderRadius.circular(10)),
          child: const Center(
            child: Text("Load More"),
          ),
        ),
      ),
    );
  }
}
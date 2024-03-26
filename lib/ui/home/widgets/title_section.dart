import 'package:flutter/material.dart';

class TitleSection extends StatelessWidget {
  const TitleSection({super.key, required this.sectionTitle});

  final String sectionTitle;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        sectionTitle,
        style: const TextStyle(
            color: Colors.black, fontWeight: FontWeight.w700, fontSize: 18),
      ),
    );
  }
}

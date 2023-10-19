import 'package:expences_tracker/widget/Small_text.dart';
import 'package:expences_tracker/widget/colors.dart';
import 'package:flutter/material.dart';

class LegendItem extends StatelessWidget {
  final Color color;
  final String label;
  final IconData icon;

  LegendItem({required this.color, required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: color,
          size: 30,
        ),
        SizedBox(width: 5),
        SmallText(
          text: label,
          color: MyColors.primaryColor,
        ),
      ],
    );
  }
}

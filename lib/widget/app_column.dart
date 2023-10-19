import 'package:expences_tracker/widget/Small_text.dart';
import 'package:expences_tracker/widget/bigText.dart';
import 'package:expences_tracker/widget/circularGraph.dart';
import 'package:expences_tracker/widget/legendItems.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'icons_and_text.dart';

class AppColumn extends StatelessWidget {
  final String text;
  const AppColumn({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(
          text: text,
          size: 26,
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Wrap(
              children: List.generate(
                  5,
                  (index) => Icon(
                        Icons.currency_rupee,
                        color: Colors.green[700],
                        size: 15,
                      )),
            ),
            SizedBox(
              width: 10,
            ),
            SmallText(text: "4.5"),
            SizedBox(
              width: 10,
            ),
            SmallText(text: "1278"),
            SizedBox(
              width: 10,
            ),
            SmallText(text: "Comments")
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconAndTextWidget(
                icon: Icons.circle_sharp,
                text: "Normal",
                iconColor: Colors.yellow),
            IconAndTextWidget(
                icon: Icons.location_on, text: "1.7", iconColor: Colors.green),
            IconAndTextWidget(
                icon: Icons.access_time_rounded,
                text: "32 mins",
                iconColor: Colors.redAccent),
          ],
        ),
      ],
    );
  }
}

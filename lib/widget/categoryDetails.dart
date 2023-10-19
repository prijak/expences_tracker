import 'package:expences_tracker/widget/Small_text.dart';
import 'package:expences_tracker/widget/bigText.dart';
import 'package:expences_tracker/widget/colors.dart';
import 'package:flutter/material.dart';

class CategoryDetails extends StatelessWidget {
  final String name;
  final Color color;
  final double expense;
  final IconData icon;
  final double budget;
  CategoryDetails({
    required this.name,
    required this.color,
    required this.expense,
    required this.icon,
    required this.budget,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(16),
      child: Container(
        padding: EdgeInsets.all(16),
        child: Row(
          children: <Widget>[
            Icon(
              icon,
              color: color,
              size: 48,
            ),
            SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                BigText(
                  text: name,
                  color: MyColors.primaryColor,
                ),
                SmallText(
                  text: 'Expense: \₹${expense.toStringAsFixed(2)}',
                  color: Colors.red,
                  size: 15,
                ),
                SmallText(
                  text: 'Budget: \₹${budget.toStringAsFixed(2)}',
                  color: Colors.green,
                  size: 15,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

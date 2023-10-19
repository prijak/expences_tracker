import 'package:flutter/material.dart';

class HorizontalIncomeExpenseGraph extends StatelessWidget {
  final double totalIncome;
  final double totalExpense;
  final double graphHeight;
  final double maxValue;

  HorizontalIncomeExpenseGraph({
    required this.totalIncome,
    required this.totalExpense,
    required this.graphHeight,
  }) : maxValue = totalIncome > totalExpense ? totalIncome : totalExpense;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: CustomPaint(
        size: Size(double.infinity, graphHeight),
        painter: HorizontalGraphPainter(
          totalIncome: totalIncome,
          totalExpense: totalExpense,
          maxValue: maxValue,
        ),
      ),
    );
  }
}

class HorizontalGraphPainter extends CustomPainter {
  final double totalIncome;
  final double totalExpense;
  final double maxValue;

  HorizontalGraphPainter({
    required this.totalIncome,
    required this.totalExpense,
    required this.maxValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint incomePaint = Paint()
      ..color = Colors.green
      ..strokeWidth = 8;
    final Paint expensePaint = Paint()
      ..color = Colors.red
      ..strokeWidth = 8;

    final double incomeWidth = (totalIncome / (totalExpense)) * size.width;
    final double expenseWidth = (totalExpense / (totalIncome)) * size.width;

    canvas.drawRect(
        Rect.fromPoints(Offset(0, 0), Offset(incomeWidth, size.height)),
        expensePaint);
    canvas.drawRect(
        Rect.fromPoints(
            Offset(expenseWidth, 0), Offset(size.width, size.height)),
        incomePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

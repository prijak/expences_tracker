import 'package:expences_tracker/model/CategoryStorage.dart';
import 'package:expences_tracker/model/category.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CircularGraph extends StatefulWidget {
  const CircularGraph({super.key});

  @override
  State<CircularGraph> createState() => _CircularGraphState();
}

class _CircularGraphState extends State<CircularGraph> {
  late List<Category> savedCategories;
  var isLoaded = false;
  late List<PieChartSectionData> pieChartSections;

  @override
  Widget build(BuildContext context) {
    getData();
    return !isLoaded
        ? Center(child: Lottie.asset("assets/image/loadingHand.json"))
        : ClipOval(
            child: Container(
              color: Colors.grey,
              child: PieChart(
                PieChartData(
                  sectionsSpace: 0,
                  centerSpaceRadius: 50,
                  sections: pieChartSections,
                ),
              ),
            ),
          );
  }

  getData() async {
    savedCategories = await CategoryStorage.getCategories();
    pieChartSections = savedCategories.map((category) {
      return PieChartSectionData(
        color: category.color,
        value: category.expense,
        radius: 40,
        showTitle: false,
      );
    }).toList();
    setState(() {
      isLoaded = true;
    });
  }
}

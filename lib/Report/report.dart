import 'dart:io';

import 'package:expences_tracker/model/ExpenseStorage.dart';
import 'package:expences_tracker/model/expences.dart';
import 'package:expences_tracker/widget/ExpenseIncomeChart.dart';
import 'package:expences_tracker/widget/Small_text.dart';
import 'package:expences_tracker/widget/bigText.dart';
import 'package:expences_tracker/widget/colors.dart';
import 'package:expences_tracker/widget/icons_and_text.dart';
import 'package:expences_tracker/widget/legendItems.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Report extends StatefulWidget {
  const Report({super.key});

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  late List<Expense> existingExpenses;
  var isLoaded = false;
  late double income, expences;
  @override
  Widget build(BuildContext context) {
    getData();
    return !isLoaded
        ? Center(
            child: Container(
                height: 190,
                width: 250,
                child: Lottie.asset("assets/image/loading.json")),
          )
        : SafeArea(
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: MyColors.backgroundColor,
                iconTheme: IconThemeData(color: MyColors.primaryColor),
                title: BigText(
                  text: "Report",
                  color: MyColors.primaryColor,
                  size: 25,
                ),
              ),
              backgroundColor: MyColors.backgroundColor,
              body: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: MyColors.tileBackgroiund,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            BigText(
                              text: "Expences to Income",
                              color: MyColors.primaryColor,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20)),
                              padding:
                                  EdgeInsets.only(left: 10, right: 10, top: 40),
                              child: HorizontalIncomeExpenseGraph(
                                totalIncome: income,
                                totalExpense: expences,
                                graphHeight: 40,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height:
                                      MediaQuery.sizeOf(context).height / 12,
                                ),
                                LegendItem(
                                    color: Colors.red,
                                    label: 'Expenses:' + expences.toString(),
                                    icon: Icons
                                        .keyboard_double_arrow_up_outlined),
                                SizedBox(
                                  width: 30,
                                ),
                                LegendItem(
                                    color: Colors.green,
                                    label: 'Income:' + income.toString(),
                                    icon: Icons
                                        .keyboard_double_arrow_down_outlined),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          itemCount: existingExpenses.length,
                          itemBuilder: ((context, index) {
                            return Container(
                              margin: EdgeInsets.only(left: 20, bottom: 10),
                              child: Row(
                                children: [
                                  Container(
                                    width: 150,
                                    height: 150,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.white38,
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: FileImage(File(
                                                existingExpenses
                                                        .elementAt(index)
                                                        .imageUrl ??
                                                    "")))),
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: 150,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(20),
                                          bottomRight: Radius.circular(20),
                                        ),
                                        color: Colors.white,
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            BigText(
                                                text: existingExpenses
                                                    .elementAt(index)
                                                    .name),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            SmallText(
                                                text: existingExpenses
                                                    .elementAt(index)
                                                    .description),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                IconAndTextWidget(
                                                    icon: Icons.currency_rupee,
                                                    text: existingExpenses
                                                        .elementAt(index)
                                                        .amount
                                                        .toString(),
                                                    iconColor: Colors.yellow),
                                                IconAndTextWidget(
                                                    icon: Icons.calendar_month,
                                                    text: existingExpenses
                                                        .elementAt(index)
                                                        .date,
                                                    iconColor: Colors.green),
                                              ],
                                            ),
                                            IconAndTextWidget(
                                                icon: Icons.category,
                                                text: existingExpenses
                                                    .elementAt(index)
                                                    .type,
                                                iconColor: Colors.redAccent),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          })),
                    ],
                  )),
            ),
          );
  }

  Future<void> getData() async {
    final prefs = await SharedPreferences.getInstance();
    existingExpenses = await ExpenseStorage.getExpenses();
    income = prefs.getDouble('income')!;
    expences = prefs.getDouble('expence')!;
    setState(() {
      isLoaded = true;
    });
  }
}

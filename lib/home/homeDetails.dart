import 'package:dots_indicator/dots_indicator.dart';
import 'package:expences_tracker/CategoryManagement/categoryManagement.dart';
import 'package:expences_tracker/ExpenceLogging/expenceLogging.dart';
import 'package:expences_tracker/Report/report.dart';
import 'package:expences_tracker/model/CategoryStorage.dart';
import 'package:expences_tracker/model/category.dart';
import 'package:expences_tracker/profile/profile.dart';
import 'package:expences_tracker/widget/ExpenseIncomeChart.dart';
import 'package:expences_tracker/widget/Small_text.dart';
import 'package:expences_tracker/widget/app_column.dart';
import 'package:expences_tracker/widget/bigText.dart';
import 'package:expences_tracker/widget/circularGraph.dart';
import 'package:expences_tracker/widget/colors.dart';
import 'package:expences_tracker/widget/icons_and_text.dart';
import 'package:expences_tracker/widget/legendItems.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class homeDetails extends StatefulWidget {
  const homeDetails({super.key});

  @override
  State<homeDetails> createState() => _homeDetailsState();
}

class _homeDetailsState extends State<homeDetails> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValue = 0.0;
  double _scalefactor = 0.8;
  double _height = 300;
  late double income, expences;
  var isloaded = false;
  late List<Category> savedCategories;
  late List<LegendItem> legendItem;
  @override
  void initState() {
    super.initState();

    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
  }

  getData() async {
    final prefs = await SharedPreferences.getInstance();

    income = prefs.getDouble('income')!;
    expences = prefs.getDouble('expence')!;

    savedCategories = await CategoryStorage.getCategories();
    legendItem = savedCategories.map((category) {
      return LegendItem(
        color: category.color,
        icon: category.icon,
        label: category.name,
      );
    }).toList();

    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        isloaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return !isloaded
        ? Center(
            child: Container(
                height: 190,
                width: 250,
                child: Lottie.asset("assets/image/loading.json")),
          )
        : Column(
            children: [
              Container(
                height: MediaQuery.sizeOf(context).height / 2.5,
                child: PageView.builder(
                    controller: pageController,
                    itemCount: 2,
                    itemBuilder: (context, position) {
                      return _buildPageItem(position);
                    }),
              ),
              new DotsIndicator(
                dotsCount: 2,
                position: _currPageValue,
                decorator: DotsDecorator(
                    activeColor: MyColors.primaryColor,
                    size: const Size.square(9.0),
                    activeSize: const Size(18.0, 9.0),
                    activeShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                margin: EdgeInsets.only(left: 30),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 3),
                      child: BigText(
                        text: "Features",
                        color: MyColors.primaryColor,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 4,
                  itemBuilder: ((context, index) {
                    if (index == 0) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => expencesLogging()),
                          );
                        },
                        child: Container(
                          margin:
                              EdgeInsets.only(left: 10, bottom: 10, right: 10),
                          child: Container(
                            width: MediaQuery.sizeOf(context).height / 2.89,
                            height: MediaQuery.sizeOf(context).height / 2.89,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.keyboard_double_arrow_up_sharp,
                                  color: Colors.red,
                                  size: 60,
                                ),
                                BigText(
                                  text: "Expense Logging",
                                  size: 15,
                                  color: MyColors.primaryColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    } else if (index == 1) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => categoryManagement()),
                          );
                        },
                        child: Container(
                          margin:
                              EdgeInsets.only(left: 10, bottom: 10, right: 10),
                          child: Container(
                            width: MediaQuery.sizeOf(context).height / 2.89,
                            height: MediaQuery.sizeOf(context).height / 2.89,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.category,
                                  color: Colors.deepPurpleAccent,
                                  size: 60,
                                ),
                                BigText(
                                  text: "Category Management",
                                  size: 15,
                                  color: MyColors.primaryColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    } else if (index == 2) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Report()),
                          );
                        },
                        child: Container(
                          margin:
                              EdgeInsets.only(left: 10, bottom: 10, right: 10),
                          child: Container(
                            width: MediaQuery.sizeOf(context).height / 2.89,
                            height: MediaQuery.sizeOf(context).height / 2.89,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.file_copy_rounded,
                                  color: Colors.blueGrey,
                                  size: 60,
                                ),
                                BigText(
                                  text: "Report",
                                  size: 15,
                                  color: MyColors.primaryColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    } else if (index == 3) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Profile()),
                          );
                        },
                        child: Container(
                          margin:
                              EdgeInsets.only(left: 10, bottom: 10, right: 10),
                          child: Container(
                            width: MediaQuery.sizeOf(context).height / 2.89,
                            height: MediaQuery.sizeOf(context).height / 2.89,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.person,
                                  color: Colors.amber,
                                  size: 60,
                                ),
                                BigText(
                                  text: "Profile",
                                  size: 15,
                                  color: MyColors.primaryColor,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                  }))
            ],
          );
  }

  Widget _buildPageItem(int index) {
    Matrix4 matrix = new Matrix4.identity();
    if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scalefactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale =
          _scalefactor + (_currPageValue - index + 1) * (1 - _scalefactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scalefactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    }

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          index == 0
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: MyColors.tileBackgroiund,
                      ),
                      height: MediaQuery.sizeOf(context).height / 2.89,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: MediaQuery.sizeOf(context).height / 4.3,
                                height: MediaQuery.sizeOf(context).height / 4.3,
                                child: CircularGraph(),
                              ),
                            ],
                          ),
                          SizedBox(width: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: savedCategories.map((category) {
                              return Column(
                                children: [
                                  LegendItem(
                                    color: category.color,
                                    label: category.name,
                                    icon: category.icon,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : Container(
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
                        padding: EdgeInsets.only(left: 10, right: 10, top: 40),
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
                            height: MediaQuery.sizeOf(context).height / 12,
                          ),
                          LegendItem(
                              color: Colors.red,
                              label: 'Expenses:' + expences.toString(),
                              icon: Icons.keyboard_double_arrow_up_outlined),
                          SizedBox(
                            width: 30,
                          ),
                          LegendItem(
                              color: Colors.green,
                              label: 'Income:' + income.toString(),
                              icon: Icons.keyboard_double_arrow_down_outlined),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}

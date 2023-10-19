import 'dart:io';

import 'package:expences_tracker/CategoryManagement/addCategory.dart';
import 'package:expences_tracker/CategoryManagement/editCategory.dart';
import 'package:expences_tracker/model/CategoryStorage.dart';
import 'package:expences_tracker/model/ExpenseStorage.dart';
import 'package:expences_tracker/model/category.dart';
import 'package:expences_tracker/model/expences.dart';
import 'package:expences_tracker/widget/Small_text.dart';
import 'package:expences_tracker/widget/bigText.dart';
import 'package:expences_tracker/widget/categoryDetails.dart';
import 'package:expences_tracker/widget/colors.dart';
import 'package:expences_tracker/widget/icons_and_text.dart';
import 'package:expences_tracker/widget/legendItems.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class categoryManagement extends StatefulWidget {
  const categoryManagement({super.key});

  @override
  State<categoryManagement> createState() => _categoryManagementState();
}

class _categoryManagementState extends State<categoryManagement> {
  late List<Category> categories;
  var isLoaded = false;

  @override
  Widget build(BuildContext context) {
    getData();

    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: MyColors.backgroundColor,
        iconTheme: IconThemeData(color: MyColors.primaryColor),
        title: BigText(
          text: "Category Management",
          color: MyColors.primaryColor,
          size: 25,
        ),
      ),
      body: !isLoaded
          ? Center(
              child: Container(
                  height: 190,
                  width: 250,
                  child: Lottie.asset("assets/image/loading.json")),
            )
          : SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: categories.length,
                      itemBuilder: ((context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditCategory(
                                        exp:
                                            categories.elementAt(index).expense,
                                        index: index,
                                        amount: categories
                                                .elementAt(index)
                                                .budget ??
                                            0.0,
                                        color:
                                            categories.elementAt(index).color,
                                        icon: categories.elementAt(index).icon,
                                        name: categories.elementAt(index).name,
                                      )),
                            );
                          },
                          child: CategoryDetails(
                            name: categories.elementAt(index).name,
                            color: categories.elementAt(index).color,
                            expense: categories.elementAt(index).expense,
                            icon: categories.elementAt(index).icon,
                            budget: categories.elementAt(index).budget ?? 0.0,
                          ),
                        );
                      })),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              if (categories.length > 5) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Alert'),
                                      content: Text(
                                          "You have reached maximum number of categories Please delete a category before proceding"),
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Dismiss'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              } else {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => addCategory()),
                                );
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: MediaQuery.sizeOf(context).width / 4.2),
                              child: LegendItem(
                                  color: MyColors.pink,
                                  label: "Add Category",
                                  icon: Icons.add),
                            ),
                            style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(horizontal: 20.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
    );
  }

  Future<void> getData() async {
    categories = await CategoryStorage.getCategories();

    setState(() {
      isLoaded = true;
    });
  }
}

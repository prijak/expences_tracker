import 'dart:ffi';
import 'dart:io';

import 'package:expences_tracker/home/mainPage.dart';
import 'package:expences_tracker/model/CategoryStorage.dart';
import 'package:expences_tracker/model/ExpenseStorage.dart';
import 'package:expences_tracker/model/category.dart';
import 'package:expences_tracker/model/expences.dart';
import 'package:expences_tracker/widget/bigText.dart';
import 'package:expences_tracker/widget/colors.dart';
import 'package:expences_tracker/widget/splash.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var isLoaded = false;
  late String username, email, image, name, gender, dob;
  late double income, updatedIncome, expences;

  final TextEditingController _textFieldController = TextEditingController();

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
        : Scaffold(
            appBar: AppBar(
              backgroundColor: MyColors.backgroundColor,
              iconTheme: IconThemeData(color: MyColors.primaryColor),
              title: BigText(
                text: "Profile",
                color: MyColors.primaryColor,
                size: 25,
              ),
            ),
            backgroundColor: MyColors.backgroundColor,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Stack(children: [
                      Container(
                        margin: EdgeInsets.only(top: 168, left: 20, right: 20),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: MyColors.tileBackgroiund,
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 40,
                            ),
                            Row(children: [
                              BigText(
                                text: "username: " + username,
                                size: 20,
                                color: MyColors.primaryColor,
                              ),
                            ]),
                            Row(children: [
                              BigText(
                                text: "email: " + email,
                                size: 20,
                                color: MyColors.primaryColor,
                              ),
                            ]),
                            Row(children: [
                              BigText(
                                text: "name: " + name,
                                size: 20,
                                color: MyColors.primaryColor,
                              ),
                            ]),
                            Row(children: [
                              BigText(
                                text: "gender: " + gender,
                                size: 20,
                                color: MyColors.primaryColor,
                              ),
                            ]),
                            Row(children: [
                              BigText(
                                text: "Date of Birth: " + dob,
                                size: 20,
                                color: MyColors.primaryColor,
                              ),
                            ]),
                            Row(children: [
                              BigText(
                                text: "income: " + income.toString(),
                                size: 20,
                                color: MyColors.primaryColor,
                              ),
                            ]),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        child: Align(
                            alignment: Alignment.topCenter,
                            child: SizedBox(
                              child: CircleAvatar(
                                radius: 100.0,
                                backgroundColor: MyColors.primaryColor,
                                child: CircleAvatar(
                                  radius: 98.0,
                                  backgroundImage: FileImage(File(image)),
                                ),
                              ),
                            )),
                      ),
                    ]),
                  ),
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
                            onPressed: _updateSalary,
                            child: Text('Update Salary'),
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: _resetData,
                            child: Text(
                              'Reset Data',
                              style: TextStyle(color: Colors.black),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.amber),
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: _deleteData,
                            child: Text(
                              'Delete All Data',
                              style: TextStyle(color: Colors.black),
                            ),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.red),
                              padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(horizontal: 20.0),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  void _updateSalary() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update Salary'),
          content: TextFormField(
            keyboardType: TextInputType.number,
            controller: _textFieldController,
            decoration: InputDecoration(labelText: 'Salary'),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                setState(() {
                  updatedIncome = double.parse(_textFieldController.text);
                });
                _salaryUpdate();
                _textFieldController.clear();
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
            ElevatedButton(
              onPressed: () {
                _textFieldController.clear();
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _salaryUpdate() async {
    final prefs = await SharedPreferences.getInstance();
    if (expences > updatedIncome) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Alert'),
            content: Text("Your Expences are more than your updated Salary!"),
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
      await prefs.setDouble('income', updatedIncome);
    }
  }

  Future<void> getData() async {
    final prefs = await SharedPreferences.getInstance();
    username = prefs.getString('username')!;
    email = prefs.getString('email')!;
    image = prefs.getString('imagePath') ?? "";
    name = prefs.getString('name')!;
    gender = prefs.getString('gender')!;
    dob = prefs.getString('dob')!;
    income = prefs.getDouble('income')!;
    expences = prefs.getDouble('expence')!;

    setState(() {
      isLoaded = true;
    });
  }

  void _resetData() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert'),
          content: Text(
              "Are you sure you want to reset all data? This will reset all your entries and all entered categories"),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('No'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isLoaded = false;
                });
                Navigator.of(context).pop();
                removeAllData();
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  Future<void> removeAllData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('expence', 0.00);
    List<Expense> allExpenses = [];
    await ExpenseStorage.saveExpenses(allExpenses);

    final Category travel = Category(
        name: 'Travel', color: Colors.purple, expense: 0, icon: Icons.flight);

    final Category food = Category(
        name: 'Food', color: Colors.red, expense: 0, icon: Icons.food_bank);

    final Category entertainment = Category(
        name: 'Entertainment',
        color: Colors.green,
        expense: 0,
        icon: Icons.movie_outlined);

    final Category other = Category(
        name: 'Other',
        color: Colors.orange,
        expense: 0,
        icon: Icons.insert_chart_outlined_sharp);

    List<Category> categories = [travel, food, entertainment, other];

    await CategoryStorage.saveCategories(categories);

    Future.delayed(Duration(seconds: 0), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (BuildContext context) => mainPage()),
          ModalRoute.withName('/home'));
    });
  }

  void _deleteData() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alert'),
          content: Text(
              "Are you sure you want to Delete all data? This will Delete everything!"),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('No'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  isLoaded = false;
                });
                Navigator.of(context).pop();
                deleteAllData();
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  Future<void> deleteAllData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    Future.delayed(Duration(seconds: 0), () {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (BuildContext context) => Splash()),
          ModalRoute.withName('/'));
    });
  }
}

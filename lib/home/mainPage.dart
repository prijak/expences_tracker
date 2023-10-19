import 'package:expences_tracker/CategoryManagement/categoryManagement.dart';
import 'package:expences_tracker/ExpenceLogging/expenceLogging.dart';
import 'package:expences_tracker/home/homeDetails.dart';
import 'package:expences_tracker/profile/profile.dart';
import 'package:expences_tracker/widget/bigText.dart';
import 'package:expences_tracker/widget/colors.dart';
import 'package:flutter/material.dart';

class mainPage extends StatefulWidget {
  const mainPage({super.key});

  @override
  State<mainPage> createState() => _mainPageState();
}

class _mainPageState extends State<mainPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        extendBody: true,
        backgroundColor: MyColors.backgroundColor,
        drawer: Drawer(
          elevation: 20,
          backgroundColor: MyColors.backgroundColor,
          child: ListView(
            children: [
              ListTile(
                selected: true,
                leading: Icon(Icons.home),
                iconColor: MyColors.primaryColor,
                title: Text('Home'),
                textColor: MyColors.primaryColor,
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.keyboard_double_arrow_up_outlined),
                iconColor: MyColors.primaryColor,
                title: Text('Expenses Logging'),
                textColor: MyColors.primaryColor,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => expencesLogging()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.category),
                iconColor: MyColors.primaryColor,
                title: Text('Category Management'),
                textColor: MyColors.primaryColor,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => categoryManagement()),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.person),
                iconColor: MyColors.primaryColor,
                title: Text('Profile'),
                textColor: MyColors.primaryColor,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Profile()),
                  );
                },
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Container(
              child: Container(
                margin: EdgeInsets.only(top: 15, bottom: 5),
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Center(
                      child: ElevatedButton(
                        onPressed: _openDrawer,
                        style: ElevatedButton.styleFrom(
                          minimumSize: Size(15, 15),
                          onPrimary: const Color.fromARGB(255, 0, 0, 0),
                          primary: MyColors.primaryColor,
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                          ),
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.height / 17.34,
                          height: MediaQuery.of(context).size.height / 17.34,
                          child: Icon(
                            Icons.menu,
                            color: Colors.white,
                            size: MediaQuery.of(context).size.height / 30.00,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: MyColors.primaryColor,
                          ),
                        ),
                      ),
                    ),
                    Column(
                      children: [
                        BigText(
                          text: "Expenses Tracker",
                          color: MyColors.primaryColor,
                          size: 30,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: homeDetails(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

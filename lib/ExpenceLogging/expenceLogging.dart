import 'dart:io';

import 'package:bottom_picker/bottom_picker.dart';
import 'package:bottom_picker/resources/arrays.dart';
import 'package:expences_tracker/home/mainPage.dart';
import 'package:expences_tracker/model/CategoryStorage.dart';
import 'package:expences_tracker/model/ExpenseStorage.dart';
import 'package:expences_tracker/model/category.dart';
import 'package:expences_tracker/model/expences.dart';
import 'package:expences_tracker/widget/bigText.dart';
import 'package:expences_tracker/widget/colors.dart';
import 'package:expences_tracker/widget/icons_and_text.dart';
import 'package:expences_tracker/widget/legendItems.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class expencesLogging extends StatefulWidget {
  const expencesLogging({super.key});

  @override
  State<expencesLogging> createState() => _expencesLoggingState();
}

class _expencesLoggingState extends State<expencesLogging> {
  late File newImage;
  bool _load = false;
  late File imageFile;
  final _formKey = GlobalKey<FormState>();
  late String _description, _name, _date, _expenceType;
  late int _amount;
  bool _isLoading = false;
  late double budget, tot, total, categtot;
  DateTime _selectedDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  var txt = TextEditingController();
  var txt1 = TextEditingController();
  late List<Category> savedCategories;
  late List<LegendItem> legendItem;
  @override
  Widget build(BuildContext context) {
    getData1();
    return _isLoading
        ? Center(
            child: Container(
                height: 190,
                width: 250,
                child: Lottie.asset("assets/image/loading.json")),
          )
        : Stack(
            children: [
              SafeArea(
                child: Scaffold(
                    backgroundColor: MyColors.backgroundColor,
                    body: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 40,
                          ),
                          _load
                              ? InkWell(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (ctx) => AlertDialog(
                                                backgroundColor:
                                                    MyColors.tileBackgroiund,
                                                title: const Text(
                                                    "Pick Image From:",
                                                    style: TextStyle(
                                                        color: MyColors
                                                            .secondaryColor)),
                                                actions: <Widget>[
                                                  Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          ElevatedButton(
                                                            onPressed: () {
                                                              _getFromGallery();
                                                              Navigator.of(ctx)
                                                                  .pop();
                                                            },
                                                            style: ElevatedButton
                                                                .styleFrom(
                                                                    backgroundColor:
                                                                        MyColors
                                                                            .secondaryColor),
                                                            child: IconAndTextWidget(
                                                                icon:
                                                                    Icons.photo,
                                                                text: "GALLERY",
                                                                iconColor: MyColors
                                                                    .backgroundColor),
                                                          ),
                                                          SizedBox(
                                                            width: 20,
                                                          ),
                                                          ElevatedButton(
                                                            onPressed: () {
                                                              _getFromCamera();
                                                              Navigator.of(ctx)
                                                                  .pop();
                                                            },
                                                            style: ElevatedButton
                                                                .styleFrom(
                                                                    backgroundColor:
                                                                        MyColors
                                                                            .secondaryColor),
                                                            child: IconAndTextWidget(
                                                                icon: Icons
                                                                    .camera_alt,
                                                                text: "CAMERA",
                                                                iconColor: MyColors
                                                                    .backgroundColor),
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Container(
                                                        width: 150,
                                                        child: ElevatedButton(
                                                          onPressed: () {
                                                            setState(() {
                                                              _load = false;
                                                            });
                                                            Navigator.of(ctx)
                                                                .pop();
                                                          },
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                                  backgroundColor:
                                                                      MyColors
                                                                          .secondaryColor),
                                                          child: IconAndTextWidget(
                                                              icon: Icons
                                                                  .image_not_supported_outlined,
                                                              text:
                                                                  "RemoveImage",
                                                              iconColor: MyColors
                                                                  .backgroundColor),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ]));
                                  },
                                  child: Container(
                                    height: 200,
                                    width: 190,
                                    child: Image.file(
                                      imageFile,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                              : InkWell(
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (ctx) => AlertDialog(
                                                backgroundColor:
                                                    MyColors.tileBackgroiund,
                                                title: const Text(
                                                    "Pick Image From:",
                                                    style: TextStyle(
                                                        color: MyColors
                                                            .secondaryColor)),
                                                actions: <Widget>[
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      ElevatedButton(
                                                        onPressed: () {
                                                          _getFromGallery();
                                                          Navigator.of(ctx)
                                                              .pop();
                                                        },
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                backgroundColor:
                                                                    MyColors
                                                                        .secondaryColor),
                                                        child: IconAndTextWidget(
                                                            icon: Icons.photo,
                                                            text: "GALLERY",
                                                            iconColor: MyColors
                                                                .backgroundColor),
                                                      ),
                                                      SizedBox(
                                                        width: 20,
                                                      ),
                                                      ElevatedButton(
                                                        onPressed: () {
                                                          _getFromCamera();
                                                          Navigator.of(ctx)
                                                              .pop();
                                                        },
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                backgroundColor:
                                                                    MyColors
                                                                        .secondaryColor),
                                                        child: IconAndTextWidget(
                                                            icon: Icons
                                                                .camera_alt,
                                                            text: "CAMERA",
                                                            iconColor: MyColors
                                                                .backgroundColor),
                                                      )
                                                    ],
                                                  ),
                                                ]));
                                  },
                                  child: Container(
                                    height: 200,
                                    width: 190,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: AssetImage(
                                                "assets/image/secondary.png"))),
                                  ),
                                ),
                          Container(
                            padding: EdgeInsets.all(40.0),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: <Widget>[
                                  TextFormField(
                                    validator: (input) {
                                      if (input!.isEmpty) {
                                        return 'Please enter expence name';
                                      }
                                    },
                                    onSaved: (input) => _name = input!,
                                    decoration: InputDecoration(
                                        errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 255, 0, 0),
                                                width: 2)),
                                        filled: true,
                                        fillColor: Colors.grey[700],
                                        labelText: 'Expence Name',
                                        labelStyle:
                                            TextStyle(color: Colors.white)),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    validator: (input) {
                                      if (input!.isEmpty) {
                                        return 'Please enter description';
                                      }
                                    },
                                    onSaved: (input) => _description = input!,
                                    decoration: InputDecoration(
                                        errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 255, 0, 0),
                                                width: 2)),
                                        filled: true,
                                        fillColor: Colors.grey[700],
                                        labelText: 'Description',
                                        labelStyle:
                                            TextStyle(color: Colors.white)),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  InkWell(
                                    child: Container(
                                      child: TextFormField(
                                        validator: (input) {
                                          if (input!.isEmpty) {
                                            return 'Select Date of expense';
                                          }
                                        },
                                        controller: txt,
                                        enabled: false,
                                        onSaved: (input) => _date = input!,
                                        onTap: () => _openDatePicker(context),
                                        decoration: InputDecoration(
                                            errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color.fromARGB(
                                                        255, 255, 0, 0),
                                                    width: 2)),
                                            filled: true,
                                            fillColor: Colors.grey[700],
                                            labelText: 'Date of Expence',
                                            labelStyle:
                                                TextStyle(color: Colors.white)),
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    onTap: () => _openDatePicker(context),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    validator: (input) {
                                      if (input!.isEmpty) {
                                        return 'Please enter an amount';
                                      }
                                      if (int.tryParse(input) == null) {
                                        return 'Please enter a valid integer';
                                      }
                                    },
                                    onSaved: (input) {
                                      _amount = int.parse(input!);
                                    },
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color.fromARGB(255, 255, 0, 0),
                                          width: 2,
                                        ),
                                      ),
                                      filled: true,
                                      fillColor: Colors.grey[700],
                                      labelText: 'Amount',
                                      labelStyle:
                                          TextStyle(color: Colors.white),
                                    ),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  InkWell(
                                    child: Container(
                                      child: TextFormField(
                                        validator: (input) {
                                          if (input!.isEmpty) {
                                            return 'Select Your expence Type';
                                          }
                                        },
                                        controller: txt1,
                                        enabled: false,
                                        onSaved: (input) =>
                                            _expenceType = input!,
                                        onChanged: (value) {
                                          setState(() {
                                            _expenceType = value;
                                          });
                                        },
                                        decoration: InputDecoration(
                                            errorBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Color.fromARGB(
                                                        255, 255, 0, 0),
                                                    width: 2)),
                                            filled: true,
                                            fillColor: Colors.grey[700],
                                            labelText: 'Expence Type',
                                            labelStyle:
                                                TextStyle(color: Colors.white)),
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    onTap: () => _showPopup(context),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  ElevatedButton(
                                      onPressed: _submit,
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: Size(double.infinity, 60),
                                        onPrimary:
                                            const Color.fromARGB(255, 0, 0, 0),
                                        primary: MyColors.primaryColor,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16),
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(20)),
                                        ),
                                      ),
                                      child: BigText(text: "Save")),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              ),
            ],
          );
  }

  void _openDatePicker(BuildContext context) {
    BottomPicker.date(
      backgroundColor: MyColors.backgroundColor,
      title: 'Date Of Birth',
      initialDateTime: _selectedDate,
      dateOrder: DatePickerDateOrder.dmy,
      maxDateTime: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day),
      pickerTextStyle: TextStyle(
        color: MyColors.primaryColor,
        fontWeight: FontWeight.bold,
        fontSize: 12,
      ),
      titleStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 15,
        color: MyColors.primaryColor,
      ),
      onChange: (index) {},
      onSubmit: (index) {
        DateTime date = index;
        setState(() {
          _selectedDate = date;
          txt.text = _selectedDate.day.toString() +
              "/" +
              _selectedDate.month.toString() +
              "/" +
              _selectedDate.year.toString();
        });
      },
      bottomPickerTheme: BottomPickerTheme.plumPlate,
    ).show(context);
  }

  _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print(_name);
      print(_description);

      setState(() {
        _isLoading = true;
        getData();
      });
    }
  }

  Future<void> getData1() async {
    savedCategories = await CategoryStorage.getCategories();

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> getData() async {
    final prefs = await SharedPreferences.getInstance();

    double apptot = prefs.getDouble("expence")! + _amount.toDouble();
    double income = prefs.getDouble("income")!;

    if (apptot > income) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Alert'),
            content: Text("Your Expences are going Above your Income"),
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

      setState(() {
        _isLoading = false;
      });
    } else {
      List<Category> categories = await CategoryStorage.getCategories();
      Category entertainmentCategory1 = categories.firstWhere(
        (category) => category.name == _expenceType,
      );

      double bud = entertainmentCategory1.budget ?? 0.0;
      double catgtot = entertainmentCategory1.expense + _amount.toDouble();
      if (bud == 0.0 || catgtot < bud) {
        List<Expense> existingExpenses = await ExpenseStorage.getExpenses();
        if (_load) {
          Expense newExpense = Expense(
              name: _name,
              description: _description,
              date: _date,
              amount: _amount.toDouble(),
              type: _expenceType,
              imageUrl: newImage.path);
          existingExpenses.add(newExpense);

          await ExpenseStorage.saveExpenses(existingExpenses);
        } else {
          Expense newExpense = Expense(
            name: _name,
            description: _description,
            date: _date,
            amount: _amount.toDouble(),
            type: _expenceType,
          );
          existingExpenses.add(newExpense);

          await ExpenseStorage.saveExpenses(existingExpenses);
        }

        Category entertainmentCategory = categories.firstWhere(
          (category) => category.name == _expenceType,
        );

        categtot = entertainmentCategory.expense + _amount.toDouble();
        entertainmentCategory.expense = categtot;
        await CategoryStorage.saveCategories(categories);

        await prefs.setDouble('expence', apptot);
        setState(() {
          _isLoading = false;
        });
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (BuildContext context) => mainPage()),
            ModalRoute.withName('/home'));
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Alert'),
              content: Text("Your Expences are going Above your Set Budget"),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isLoading = false;
                    });
                    Navigator.of(context).pop();
                  },
                  child: Text('Dismiss'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );

    if (pickedFile != null) {
      final directory = await getApplicationDocumentsDirectory();

      String fileName = "expences" +
          DateTime.now().millisecondsSinceEpoch.toString() +
          ".png";

      newImage = File('${directory.path}/$fileName');

      await File(pickedFile.path).copy(newImage.path);

      setState(() {
        imageFile = newImage;
        _load = true;
      });
    }
  }

  _getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickedFile != null) {
      final directory = await getApplicationDocumentsDirectory();

      String fileName = "expences" +
          DateTime.now().millisecondsSinceEpoch.toString() +
          ".png";

      newImage = File('${directory.path}/$fileName');

      await File(pickedFile.path).copy(newImage.path);

      setState(() {
        imageFile = newImage;
        _load = true;
      });
    }
  }

  void _showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actionsAlignment: MainAxisAlignment.center,
          backgroundColor: MyColors.tileBackgroiund,
          actions: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: savedCategories.map((category) {
                return Column(
                  children: [
                    ElevatedButton(
                      child: Container(
                        height: 30,
                        width: double.infinity,
                        child: LegendItem(
                            color: category.color,
                            label: category.name,
                            icon: category.icon),
                      ),
                      onPressed: () => {
                        Navigator.pop(context),
                        txt1.text = category.name,
                        setState(() {
                          budget = category.budget ?? 0.0;
                          categtot = category.total ?? 0.0;
                        }),
                      },
                    ),
                  ],
                );
              }).toList(),
            ),
          ],
        );
      },
    );
  }
}

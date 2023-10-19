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
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _load = false;
  late File imageFile;
  final _formKey = GlobalKey<FormState>();
  late String _email, _password, _username, _dob, _firstName, _gender;
  late int _amount;
  late String _selecteddob;
  bool _isLoading = false;
  late String _selectedGender;
  DateTime _selectedDate = DateTime(
      DateTime.now().year - 18, DateTime.now().month, DateTime.now().day);
  var txt = TextEditingController();
  var txt1 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Stack(
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
                    Center(
                      child: _load
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
                                                        Navigator.of(ctx).pop();
                                                      },
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              backgroundColor:
                                                                  MyColors
                                                                      .secondaryColor),
                                                      child: IconAndTextWidget(
                                                          icon: Icons
                                                              .image_not_supported_outlined,
                                                          text: "RemoveImage",
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
                                                    MainAxisAlignment.center,
                                                children: [
                                                  ElevatedButton(
                                                    onPressed: () {
                                                      _getFromGallery();
                                                      Navigator.of(ctx).pop();
                                                    },
                                                    style: ElevatedButton.styleFrom(
                                                        backgroundColor: MyColors
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
                                                      Navigator.of(ctx).pop();
                                                    },
                                                    style: ElevatedButton.styleFrom(
                                                        backgroundColor: MyColors
                                                            .secondaryColor),
                                                    child: IconAndTextWidget(
                                                        icon: Icons.camera_alt,
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
                                  return 'Please enter your username';
                                }
                              },
                              onSaved: (input) => _username = input!,
                              decoration: InputDecoration(
                                  errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(255, 255, 0, 0),
                                          width: 2)),
                                  filled: true,
                                  fillColor: Colors.grey[700],
                                  labelText: 'Username',
                                  labelStyle: TextStyle(color: Colors.white)),
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              validator: (input) {
                                final bool emailValid = RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(input.toString());

                                print(input.toString() + " Email");
                                if (input!.isEmpty) {
                                  return 'Please enter your Email';
                                } else if (!emailValid) {
                                  return 'Please enter a valid Email';
                                }
                              },
                              onSaved: (input) => _email = input!,
                              decoration: InputDecoration(
                                  errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(255, 255, 0, 0),
                                          width: 2)),
                                  filled: true,
                                  fillColor: Colors.grey[700],
                                  labelText: 'Email',
                                  labelStyle: TextStyle(color: Colors.white)),
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              validator: (input) {
                                if (input!.isEmpty) {
                                  return 'Please enter your  Name';
                                }
                              },
                              onSaved: (input) => _firstName = input!,
                              decoration: InputDecoration(
                                  errorBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(255, 255, 0, 0),
                                          width: 2)),
                                  filled: true,
                                  fillColor: Colors.grey[700],
                                  labelText: 'Name',
                                  labelStyle: TextStyle(color: Colors.white)),
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
                                      return 'Select Your Gender';
                                    }
                                  },
                                  controller: txt1,
                                  enabled: false,
                                  onSaved: (input) => _gender = input!,
                                  onChanged: (value) {
                                    setState(() {
                                      _gender = value;
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
                                      labelText: 'Gender',
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
                            InkWell(
                              child: Container(
                                child: TextFormField(
                                  validator: (input) {
                                    if (input!.isEmpty) {
                                      return 'Select Date of Birth';
                                    }
                                  },
                                  controller: txt,
                                  enabled: false,
                                  onSaved: (input) => _dob = input!,
                                  onTap: () => _openDatePicker(context),
                                  decoration: InputDecoration(
                                      errorBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color.fromARGB(
                                                  255, 255, 0, 0),
                                              width: 2)),
                                      filled: true,
                                      fillColor: Colors.grey[700],
                                      labelText: 'Date of Birth',
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
                                labelText: 'Monthly Income',
                                labelStyle: TextStyle(color: Colors.white),
                              ),
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                                onPressed: _submit,
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(double.infinity, 60),
                                  onPrimary: const Color.fromARGB(255, 0, 0, 0),
                                  primary: MyColors.primaryColor,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20)),
                                  ),
                                ),
                                child: BigText(text: "Register")),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ),
        if (_isLoading)
          const Opacity(
            opacity: 0.8,
            child: ModalBarrier(dismissible: false, color: Colors.black),
          ),
        if (_isLoading)
          Center(
            child: Container(
                height: 190,
                width: 250,
                child: Lottie.asset("assets/image/loading.json")),
          ),
      ],
    );
  }

  _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print(_email);
      print(_username);

      setState(() {
        _isLoading = true;

        getData();
      });
    }
  }

  Future<void> getData() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('username', _username);
    await prefs.setString('email', _email);
    await prefs.setString('name', _firstName);
    await prefs.setString('gender', _gender);
    await prefs.setString('dob', _dob);
    await prefs.setDouble('income', _amount.toDouble());
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

    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        _isLoading = false;
      });
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (BuildContext context) => mainPage()),
          ModalRoute.withName('/home'));
    });
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
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: Container(
                    height: 30,
                    width: 70,
                    child: IconAndTextWidget(
                        icon: Icons.boy,
                        text: "Male",
                        iconColor: MyColors.primaryColor),
                  ),
                  onPressed: () => {
                    Navigator.pop(context),
                    txt1.text = "Male",
                  },
                ),
                ElevatedButton(
                  child: Container(
                    height: 30,
                    width: 70,
                    child: IconAndTextWidget(
                        icon: Icons.girl,
                        text: "Female",
                        iconColor: MyColors.primaryColor),
                  ),
                  onPressed: () => {
                    Navigator.pop(context),
                    txt1.text = "Female",
                  },
                ),
              ],
            )
          ],
        );
      },
    );
  }

  void _openDatePicker(BuildContext context) {
    BottomPicker.date(
      backgroundColor: MyColors.backgroundColor,
      title: 'Date Of Birth',
      initialDateTime: _selectedDate,
      dateOrder: DatePickerDateOrder.dmy,
      maxDateTime: DateTime(
          DateTime.now().year - 18, DateTime.now().month, DateTime.now().day),
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

  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );

    if (pickedFile != null) {
      final directory = await getApplicationDocumentsDirectory();

      String fileName =
          DateTime.now().millisecondsSinceEpoch.toString() + ".png";

      File newImage = File('${directory.path}/$fileName');

      await File(pickedFile.path).copy(newImage.path);

      final prefs = await SharedPreferences.getInstance();
      prefs.setString('imagePath', newImage.path);

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

      String fileName =
          DateTime.now().millisecondsSinceEpoch.toString() + ".png";

      File newImage = File('${directory.path}/$fileName');

      await File(pickedFile.path).copy(newImage.path);

      final prefs = await SharedPreferences.getInstance();
      prefs.setString('imagePath', newImage.path);

      setState(() {
        imageFile = newImage;
        _load = true;
      });
    }
  }
}

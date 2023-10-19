import 'package:expences_tracker/home/mainPage.dart';
import 'package:expences_tracker/register/register.dart';
import 'package:expences_tracker/widget/splash.dart';
import 'package:flutter/material.dart';

var customRoutes = <String, WidgetBuilder>{
  '/': (context) => Splash(),
  '/home': (context) => mainPage(),
};

import 'dart:ui';

import 'package:flutter/material.dart';

class Category {
  String name;
  Color color;
  double expense;
  IconData icon;
  double? budget;
  double? total;

  Category({
    required this.name,
    required this.color,
    required this.expense,
    required this.icon,
    this.budget = 0.0,
    this.total = 0.0,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'color': color.value,
      'expense': expense,
      'icon': icon.codePoint,
      'budget': budget,
      'total': total,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      name: map['name'],
      color: Color(map['color']),
      expense: map['expense'],
      icon: IconData(map['icon'], fontFamily: 'MaterialIcons'),
      budget: map['budget'],
      total: map['total'],
    );
  }
}

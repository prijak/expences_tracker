import 'dart:convert';

import 'package:expences_tracker/model/category.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryStorage {
  static const _categoriesKey = 'categories';

  static Future<void> saveCategories(List<Category> categories) async {
    final prefs = await SharedPreferences.getInstance();
    final categoryList =
        categories.map((category) => category.toMap()).toList();
    prefs.setStringList(
      _categoriesKey,
      categoryList.map((e) => json.encode(e)).toList(),
    );
  }

  static Future<List<Category>> getCategories() async {
    final prefs = await SharedPreferences.getInstance();
    final categoryList = prefs.getStringList(_categoriesKey);

    if (categoryList == null) {
      return [];
    }

    final categories = categoryList
        .map((category) => Category.fromMap(json.decode(category)))
        .toList();
    return categories;
  }
}

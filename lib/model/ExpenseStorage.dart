import 'dart:convert';

import 'package:expences_tracker/model/expences.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExpenseStorage {
  static const _expensesKey = 'expenses';

  static Future<void> saveExpenses(List<Expense> expenses) async {
    final prefs = await SharedPreferences.getInstance();
    final expenseList = expenses.map((expense) => expense.toMap()).toList();
    prefs.setStringList(
      _expensesKey,
      expenseList.map((e) => json.encode(e)).toList(),
    );
  }

  static Future<List<Expense>> getExpenses() async {
    final prefs = await SharedPreferences.getInstance();
    final expenseList = prefs.getStringList(_expensesKey);

    if (expenseList == null) {
      return [];
    }

    final expenses = expenseList
        .map((expense) => Expense.fromMap(json.decode(expense)))
        .toList();
    return expenses;
  }
}

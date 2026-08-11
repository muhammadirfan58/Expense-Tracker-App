import 'package:flutter/material.dart';

import '../database/database_helper.dart';
import '../models/expense.dart';

class ExpenseProvider extends ChangeNotifier {
  List<Expense> _expenses = [];

  List<Expense> get expenses => _expenses;

  double get totalExpense {
    return _expenses.fold(
      0,
      (sum, expense) => sum + expense.amount,
    );
  }

  Future<void> loadExpenses() async {
    _expenses = await DatabaseHelper.instance.getExpenses();
    notifyListeners();
  }

  Future<void> addExpense(Expense expense) async {
    await DatabaseHelper.instance.addExpense(expense);
    await loadExpenses();
  }

  Future<void> updateExpense(Expense expense) async {
    await DatabaseHelper.instance.updateExpense(expense);
    await loadExpenses();
  }

  Future<void> deleteExpense(int id) async {
    await DatabaseHelper.instance.deleteExpense(id);
    await loadExpenses();
  }
}

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class TransactionProvider extends ChangeNotifier {
  final Box _box = Hive.box('transaction');

  List<Map<String, dynamic>> get transaction {
    return _box.values
        .map((e) => Map<String, dynamic>.from(e))
        .toList();
  }

  double get totalIncome {
    return transaction
        .where((t) => t['isIncome'] == true)
        .fold(0.0, (sum, t) => sum + (t['amount'] as num).toDouble());
  }

  double get totalExpense {
    return transaction
        .where((t) => t['isIncome'] == false)
        .fold(0.0, (sum, t) => sum + (t['amount'] as num).toDouble());
  }

  double get balance => totalIncome - totalExpense;

  void addTransaction(String title, double amount, bool isIncome) {
    final data = {
      'title': title,
      'amount': amount,
      'isIncome': isIncome,
      'date': DateTime.now().toIso8601String(),
    };

    _box.add(data);
    notifyListeners();
  }

  void deleteTransaction(int index) {
    _box.deleteAt(index);
    notifyListeners();
  }
}

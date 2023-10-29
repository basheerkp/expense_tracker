import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

final formatter = DateFormat.yMd();
const uuid = Uuid();

enum Categories { leisure, food, travel, work }

const categoryIcon = {
  Categories.leisure: Icons.movie,
  Categories.food: Icons.fastfood,
  Categories.travel: Icons.flight_takeoff,
  Categories.work: Icons.work
};

class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Categories category;

  String get formattedDate {
    return formatter.format(date);
  }

  Map<String, dynamic> mapExpense() {
    return {
      'title': title,
      'amount': amount,
      'category': category.toString(),
      'date': date.toString().substring(0, 10),
    };
  }
}

class ChartMaker {
  ChartMaker({required this.category, required this.expenses});

  ChartMaker.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses
            .where((expense) => expense.category == category ? true : false)
            .toList();

  Categories category;
  List<Expense> expenses;

  double get totalExpense {
    double sum = 0;
    for (final exp in expenses) {
      sum += exp.amount;
    }
    return sum;
  }
}

part of 'package:expense_tracker/widgets/expenses.dart';

List<Expense> _registeredExpenses = [
  Expense(
      title: "movie",
      amount: 150,
      date: DateTime(2023, 10, 21, 15, 51),
      category: Categories.leisure),
  Expense(
      title: "trip",
      amount: 450,
      date: DateTime(2023, 10, 23, 02, 24),
      category: Categories.travel),
  Expense(
      title: "Dinner",
      amount: 140,
      date: DateTime(2023, 10, 22, 13, 37),
      category: Categories.food),
  Expense(
      title: "Taxi",
      amount: 200,
      date: DateTime(2023, 10, 24, 11, 25),
      category: Categories.work),
];

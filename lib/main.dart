import 'package:expense_tracker/widgets/expenses.dart';
import 'package:flutter/material.dart';

ColorScheme theme = const ColorScheme.highContrastDark();

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        colorScheme: const ColorScheme.light(),
        useMaterial3: true,
        cardTheme: const CardTheme().copyWith(
            margin: const EdgeInsets.only(top: 10, left: 10, right: 10)),
        textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.black)),
        iconTheme: IconThemeData(color: Colors.blue[300])),
    darkTheme: ThemeData(
        colorScheme: const ColorScheme.dark(),
        useMaterial3: true,
        cardTheme: const CardTheme().copyWith(
            color: Colors.blue[300],
            margin: const EdgeInsets.only(top: 10, left: 10, right: 10)),
        iconTheme: const IconThemeData(color: Colors.white)),
    home: const Expenses(),
    color: Colors.black,
    title: "Expense Tracker",
  ));
}

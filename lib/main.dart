import 'package:expense_tracker/widgets/expenses.dart';
import 'package:flutter/material.dart';

ColorScheme theme = const ColorScheme.highContrastDark();

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        colorScheme: ColorScheme.dark(),
        useMaterial3: true,
        cardTheme: const CardTheme().copyWith(
            color: Colors.blueGrey,
            margin: const EdgeInsets.only(top: 10, left: 10, right: 10)),
        textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white)),
    home: Expenses(),
    color: Colors.black,
    title: "Expense Tracker",
  ));
}

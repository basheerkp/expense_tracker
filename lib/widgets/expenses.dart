import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:flutter/material.dart';

import '../models/expense.dart';
part 'package:expense_tracker/data/savedExpense.dart';
class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense Tracker App"),
      ),
      body: Column(
        children: [Expanded(child: expense_list(_registeredExpenses))],
      ),
    );
  }
}

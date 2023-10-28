import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/widgets/graph/graph.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/expense.dart';

part 'package:expense_tracker/data/savedexpenses.dart';

part 'popupBox.dart';

class Expenses extends StatefulWidget {
  const Expenses({
    super.key,
  });

  @override
  State<StatefulWidget> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  void _writeInfo(Expense expense) {
    setState(() {
      _registeredExpenses.add(expense);
    });
  }

  void deleteExpense(Expense value) {
    final deleted = _registeredExpenses.indexOf(value);
    setState(() {
      _registeredExpenses.remove(value);
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 4),
      content: Row(
        children: [
          const Text("Expense Deleted"),
          IconButton(
              onPressed: () {
                setState(() {
                  _registeredExpenses.insert(deleted, value);
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                });
              },
              icon: const Icon(
                Icons.undo_sharp,
                color: Colors.black,
              ))
        ],
      ),
    ));
  }

  bool on = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expense Tracker App"),
        actions: [
          Switch.adaptive(
              activeColor: Colors.white,
              inactiveThumbColor: Colors.white,
              value: on,
              onChanged: (value) {
                setState(() {
                  on = value;
                });
              }),
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => PopupBox(
                          writer: _writeInfo,
                        ));
              },
              icon: const Icon(Icons.add_rounded))
        ],
      ),
      body: Column(
        children: [
          Graph(expenses: _registeredExpenses),
          const SizedBox(
            height: 50,
          ),
          Expanded(
              child: ExpenseList(_registeredExpenses, deleter: deleteExpense))
        ],
      ),
    );
  }
}

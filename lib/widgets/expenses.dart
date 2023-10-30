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

class _ExpensesState extends State<Expenses>
    with SingleTickerProviderStateMixin {
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
      duration: const Duration(seconds: 1, milliseconds: 400),
      content: Row(
        children: [
          const Text("Expense Deleted"),
          TextButton(
            onPressed: () {
              setState(() {
                _registeredExpenses.insert(deleted, value);
                ScaffoldMessenger.of(context).removeCurrentSnackBar();
              });
            },
            child: const Text("Undo"),
          )
        ],
      ),
    ));
  }

  bool on = true;

  @override
  Widget build(BuildContext context) {
    var rotated =
        MediaQuery.of(context).size.height > MediaQuery.of(context).size.width
            ? true
            : false;
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
                  print(MediaQuery.of(context).size.height);
                  print(MediaQuery.of(context).devicePixelRatio);
                },
                icon: const Icon(Icons.add_rounded))
          ],
        ),
        body: rotated
            ? Column(
                children: [
                  Graph(expenses: _registeredExpenses),
                  const SizedBox(
                    height: 50,
                  ),
                  Expanded(
                      child: ExpenseList(_registeredExpenses,
                          deleter: deleteExpense)),
                ],
              )
            : Row(
                children: [
                  Graph(expenses: _registeredExpenses),
                  const SizedBox(
                    width: 50,
                  ),
                  Expanded(
                      child: ExpenseList(_registeredExpenses,
                          deleter: deleteExpense)),
                ],
              ));
  }
}

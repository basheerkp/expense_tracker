import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/widgets/graph/graph.dart';
import 'package:flutter/material.dart';

import '../models/expense.dart';

part 'package:expense_tracker/data/saved_expenses.dart';
part 'popup_box.dart';

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
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    bool rotated = MediaQuery.of(context).orientation == Orientation.landscape
        ? true
        : false;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Expense Tracker App"),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) => PopupBox(
                            width: w,
                            height: h,
                            rotated: rotated,
                            writer: _writeInfo,
                          ));
                },
                icon: const Icon(Icons.add_rounded))
          ],
        ),
        body: rotated
            ? Row(
                children: [
                  Container(
                    margin: EdgeInsets.all((h - 378) / 2),
                    alignment: Alignment.center,
                    child: Graph(expenses: _registeredExpenses),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: ExpenseList(
                    _registeredExpenses,
                    deleter: deleteExpense,
                    h: h,
                    w: w,
                  )),
                ],
              )
            : Column(
                children: [
                  Container(
                    margin: EdgeInsets.all((w - 378) / 2),
                    alignment: Alignment.center,
                    child: Graph(expenses: _registeredExpenses),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: ExpenseList(
                      _registeredExpenses,
                      deleter: deleteExpense,
                      w: w,
                      h: h,
                    ),
                  ),
                ],
              ));
  }
}

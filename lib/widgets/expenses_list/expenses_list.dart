import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';

import '../../models/expense.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList(
    this.expenses, {
    required this.deleter,
    required this.w,
    required this.h,
    super.key,
  });

  final double w;
  final double h;

  final Function(Expense value) deleter;
  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) {
        return Dismissible(
          key: ValueKey(expenses[index]),
          onDismissed: (direction) {
            deleter(expenses[index]);
          },
          child: ExpenseItem(
            expenses[index],
            h: h,
            w: w,
          ),
        );
      },
    );
  }
}

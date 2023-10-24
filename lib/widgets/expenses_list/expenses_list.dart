import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';

import '../../models/expense.dart';

class expense_list extends StatelessWidget {
  expense_list(
    this.expenses, {
    super.key,
  });

  final List<Expense> expenses;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) {
        return ExpenseItem(expenses[index]);
      },
    );
  }
}

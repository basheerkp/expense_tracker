import 'package:expense_tracker/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense,
      {super.key, required this.h, required this.w});

  final double h;
  final double w;
  final Expense expense;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Card(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            children: [
              Text(expense.title.toUpperCase()),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Text('\$${expense.amount.toStringAsFixed(2)}'),
                  const Spacer(),
                  Row(
                    children: [
                      Icon(categoryIcon[expense.category]),
                      Text("   ${expense.formattedDate}")
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

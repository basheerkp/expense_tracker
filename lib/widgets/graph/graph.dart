import 'package:flutter/material.dart';

import '../../models/expense.dart';
import 'graphbar.dart';

class Graph extends StatefulWidget {
  const Graph({super.key, required this.expenses});

  final List<Expense> expenses;

  List<ChartMaker> get charts {
    return [
      ChartMaker.forCategory(expenses, Categories.leisure),
      ChartMaker.forCategory(expenses, Categories.food),
      ChartMaker.forCategory(expenses, Categories.work),
      ChartMaker.forCategory(expenses, Categories.travel),
    ];
  }

  double get maxExpense {
    double max = 0;
    for (final i in charts) {
      if (i.totalExpense > max) max = i.totalExpense;
    }
    return max;
  }

  @override
  State<StatefulWidget> createState() {
    return _GraphState();
  }
}

class _GraphState extends State<Graph> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(border: Border.all(color: Colors.blue[200]!, width: 2)),
      margin: const EdgeInsets.only(left: 5),
      height: 220,
      width: 400,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          for (final i in widget.charts) ...{
            Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              const SizedBox(),
              GraphBar(height: i.totalExpense / widget.maxExpense),
              const SizedBox(
                height: 10,
              ),
              Icon(
                categoryIcon[i.category],
              ),
              const SizedBox(
                height: 10,
              )
            ]),
            const SizedBox(
              width: 50,
            )
          }
        ],
      ),
    );
  }
}

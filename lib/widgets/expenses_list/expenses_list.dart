
import 'package:flutter/material.dart';
import 'package:tracker_app/models/expense.dart';
import 'package:tracker_app/widgets/expenses_list/expenses_item.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({super.key, required this.expenses, required this.onDeleteExpense});

  final List<Expense> expenses;
  final void Function(Expense) onDeleteExpense;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Dismissible(key: ValueKey(expenses[index]),background: Container(color: Theme.of(context).colorScheme.error.withOpacity(0.75), margin: EdgeInsets.symmetric(horizontal: Theme.of(context).cardTheme.margin!.horizontal),),onDismissed: (direction) {onDeleteExpense(expenses[index]);},child: ExpenseItem(expenses[index])) ,
    );
  }
}
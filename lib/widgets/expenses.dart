import 'package:flutter/material.dart';
import 'package:tracker_app/widgets/expenses_list/expenses_list.dart';
import 'package:tracker_app/models/expense.dart';
import 'package:tracker_app/widgets/new_expense.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpense = [
    Expense(title: 'Flutter', amount: 19.99, date: DateTime.now(), category: Category.work),
    Expense(title: 'Cinema', amount: 15.69, date: DateTime.now(), category: Category.leisure),
  ];

  void _openAddExpenseOverlay(){
    showModalBottomSheet(isScrollControlled: true,context: context, builder: (ctx) =>  NewExpense(onAddExpense: _addExpense,),);
  }

  void _addExpense(Expense expense){
    setState(() {
      _registeredExpense.add(expense);
    });
  }

  void _DeleteExpense(Expense expense){
    setState(() {
      _registeredExpense.remove(expense);
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Flutter ExpensesTracker'),
        actions: [
          IconButton(onPressed: _openAddExpenseOverlay, icon: const Icon(Icons.add)),
        ],
      ),
      body: Column(
        children:  [
          const Text('The chart'),
          Expanded(child: ExpensesList(expenses: _registeredExpense, onDeleteExpense: _DeleteExpense,),),
        ],
      ),
    );
  }
}
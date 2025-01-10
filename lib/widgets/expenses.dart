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
    final expenseIndex = _registeredExpense.indexOf(expense);
    setState(() {
      _registeredExpense.remove(expense);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content:  Text('Expense of ${expense.title} deleted!'), duration: const Duration(seconds: 2),
      action: SnackBarAction(label: 'Undo', onPressed: () {
        setState(() {
          _registeredExpense.insert(expenseIndex, expense);
        });
      }),),
    );
  }

  @override
  Widget build(BuildContext context) {

    Widget mainContent = const Center(
    child: Text('No expenses found. Start adding some!'),
  );

  if (_registeredExpense.isNotEmpty){
    mainContent = ExpensesList(expenses: _registeredExpense, onDeleteExpense: _DeleteExpense,);
  }

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
          Expanded(child: mainContent),
        ],
      ),
    );
  }
}
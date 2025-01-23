import 'package:flutter/material.dart';
import 'package:tracker_app/models/expense.dart';
import 'package:flutter/services.dart';
class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;
  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(context: context, firstDate: firstDate, lastDate: now);
    setState(() {
    _selectedDate = pickedDate as DateTime;
    });
  }

  void _submitExpenseData (){
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty || amountIsInvalid || _selectedDate == null ){
      // show error message
      showDialog(context: context, builder: (ctx) => AlertDialog(
        title: const Text('Invalid input'),
        content: const Text('Please enter a valid title, amount and date!'),
        actions: [
          TextButton(onPressed: () {Navigator.pop(ctx);}, child: const Text('Okay')),
        ],
      ),);
      return;
    }
    widget.onAddExpense(Expense(title: _titleController.text, amount: enteredAmount, date: _selectedDate!, category: _selectedCategory));
    Navigator.pop(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.fromLTRB(16,48,16,16),
      child: Column(
        children: [
           TextField(
            controller: _titleController,
            maxLength: 50,
            decoration: const InputDecoration(label: Text('Title')),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(prefixText: 'VND ', label: Text('Amount')),
                            ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(_selectedDate == null ? 'No Date Chosen!' : formatter.format(_selectedDate!)),
                    IconButton(
                      onPressed: _presentDatePicker, 
                      icon: const Icon(Icons.calendar_month),
                    )
                  ],
                )
              )
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              DropdownButton(value: _selectedCategory,items: Category.values.map((category) => DropdownMenuItem(value:category, child: Text(category.name.toUpperCase()))).toList(), onChanged: (value) {
                if (value == null){
                  return;
                }
                setState(() {
                  _selectedCategory = value;
                });
              }),
              const Spacer(),
              ElevatedButton(onPressed: _submitExpenseData, child: const Text('Save Expense'),),
            const Expanded(child: SizedBox()), // Tạo khoảng trống giữa các button
              ElevatedButton(onPressed: () {
              _titleController.clear();
              _amountController.clear();
              Navigator.pop(context);
            }, child: const Text('Cancel'),)
            ],
          )
        ],
      ),
    );
  }
}
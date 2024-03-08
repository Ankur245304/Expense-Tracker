import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:intl/intl.dart';

class AddExpense extends StatefulWidget {
  const AddExpense({super.key, required this.onAddExpense});
  final void Function(Expense expense) onAddExpense;

  @override
  State<AddExpense> createState() {
    return AddExpenseState();
  }
}

class AddExpenseState extends State<AddExpense> {
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  var selectedDate = 'No date selected';
  var outputFormat = DateFormat('dd/MM/yyyy');

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void submitData() {
    final amount = double.tryParse(_amountController.text);
    final name = _nameController.text.trim().isEmpty;
    final amountIsInvalid = amount == null || amount <= 0;
    if (name || amountIsInvalid || selectedDate == 'No date selected') {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Input'),
          content: const Text(
              'Please make sure a valid title, amount, date is entered'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Okay'))
          ],
        ),
      );
    } else {
      widget.onAddExpense(Expense(
          name: _nameController.text,
          date: pickedDate!,
          amount: double.parse(_amountController.text),
          category: item));
      Navigator.pop(context);
    }
  }

  DateTime? pickedDate;
  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);

    pickedDate = await showDatePicker(
        context: context,
        firstDate: firstDate,
        initialDate: now,
        lastDate: now);
    setState(() {
      selectedDate = outputFormat.format(pickedDate!);
    });
  }

  var item = Category.food;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(children: [
        TextField(
          maxLength: 50,
          decoration: const InputDecoration(
            label: Text('Name'),
          ),
          controller: _nameController,
          autocorrect: true,
        ),
        Row(
          children: [
            Expanded(
              child: TextField(
                keyboardType: TextInputType.number,
                textAlign: TextAlign.left,
                decoration: const InputDecoration(
                    label: Text('Amount'), prefixText: 'Rs'),
                controller: _amountController,
              ),
            ),
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(selectedDate),
                IconButton(
                    onPressed: _presentDatePicker,
                    icon: const Icon(Icons.calendar_month))
              ],
            ))
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            DropdownButton(
                value: item,
                items: Category.values
                    .map(
                      (category) => DropdownMenuItem(
                        value: category,
                        child: Text(category.name.toUpperCase()),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    item = value!;
                  });
                }),
            const Spacer(),
            TextButton(
                autofocus: false,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Clear',
                  style: TextStyle(color: Colors.black),
                )),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
              autofocus: true,
              onPressed: submitData,
              child:
                  const Text("Submit", style: TextStyle(color: Colors.black)),
            ),
          ],
        )
      ]),
    );
  }
}

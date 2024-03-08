import 'package:expense_tracker/widgets/expense_list/add_expense.dart';
import 'package:expense_tracker/widgets/expense_list/expense_list.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.changeScreen, required this.main});
  final void Function(int flag) changeScreen;
  final void Function() main;
  @override
  State<HomeScreen> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  var icon = const Icon(Icons.light_mode);
  int flag = 0;
  void changeTheme() {
    setState(() {
      if (flag == 1) {
        icon = const Icon(Icons.dark_mode);

        flag = 0;
      } else if (flag == 0) {
        icon = const Icon(Icons.light_mode);
        flag = 1;
      }
      widget.changeScreen(flag);
      widget.main();
    });
  }

  final List<Expense> _registeredExpense = [
    Expense(
        name: 'alok',
        date: DateTime.now(),
        amount: 500,
        category: Category.food),
    Expense(
        name: 'alok',
        date: DateTime.now(),
        amount: 500,
        category: Category.work)
  ];
  void _openExpenseOverlay() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) => AddExpense(
              onAddExpense: addExpense,
            ));
  }

  void removeExpense(Expense expense) {
    final removedIndex = _registeredExpense.indexOf(expense);
    setState(() {
      _registeredExpense.remove(expense);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _registeredExpense.insert(removedIndex, expense);
            });
          },
        ),
        content: const Text("Expense Deleted"),
      ),
    );
  }

  void addExpense(Expense expense) {
    setState(() {
      _registeredExpense.add(expense);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent =
        const Center(child: Text("No expense entered, add some expense"));
    if (_registeredExpense.isNotEmpty) {
      mainContent = ExpenseList(
        expenses: _registeredExpense,
        onRemove: removeExpense,
      );
    }
    return Scaffold(
      appBar: AppBar(title: const Text("Expense Tracker "), actions: [
        IconButton(
          onPressed: _openExpenseOverlay,
          icon: const Icon(Icons.add),
        ),
        IconButton(onPressed: changeTheme, icon: icon)
      ]),
      body: Column(
        children: [
          const Text("Chart"),
          Expanded(child: mainContent),
        ],
      ),
    );
  }
}

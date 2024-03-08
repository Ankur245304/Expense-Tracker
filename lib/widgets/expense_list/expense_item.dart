import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});
  final Expense expense;
  IconData icon(Expense expense) {
    if (expense.category == Category.food) {
      return Icons.lunch_dining;
    } else if (expense.category == Category.work) {
      return Icons.work;
    } else if (expense.category == Category.leisure) {
      return Icons.movie;
    } else {
      return Icons.flight_takeoff;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              expense.name[0].toUpperCase() + expense.name.substring(1),
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text(
                  ' Rs ${expense.amount.toStringAsFixed(2)}',
                ),
                const Spacer(),
                Row(
                  children: [
                    Icon(icon(expense)),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(expense.formattedDate),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

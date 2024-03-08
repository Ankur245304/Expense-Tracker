import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final outputFormat = DateFormat('dd/MM/yyyy');
const uuid = Uuid();

enum Category { food, work, leisure, travel }

class Expense {
  Expense(
      {required this.name,
      required this.date,
      required this.amount,
      required this.category})
      : id = uuid.v4();
  final String id;
  final String name;
  final DateTime date;
  final double amount;
  final Category category;
  String get formattedDate {
    return outputFormat.format(date);
  }
}

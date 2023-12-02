import 'package:dongestoon/models/receipt.dart';
import 'package:dongestoon/models/user.dart';

class Transaction {
  String id;
  String message;
  DateTime date;
  double amount;
  User originalUser;
  User destinationUser;
  Receipt? receipt;

  Transaction({
    required this.id,
    required this.originalUser,
    required this.destinationUser,
    required this.message,
    required this.date,
    required this.amount,
    this.receipt,
  });
}

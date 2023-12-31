import 'package:dongestoon/models/user.dart';

class Expense {
  String id;
  String name;
  User user;
  String category;
  String groupId;
  DateTime date;
  double amount;
  String? description;
  List<User>? includedUsers;

  Expense(
      {required this.id,
        required this.name,
      required this.user,
      required this.category,
      required this.groupId,
      required this.date,
      required this.amount,
      this.description,
      this.includedUsers});
}

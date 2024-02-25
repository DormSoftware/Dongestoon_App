import 'package:dongestoon/models/expense.dart';
import 'package:dongestoon/models/group.dart';
import 'package:dongestoon/models/transaction.dart';

class User {
  String? id;
  String userName;
  String name;
  String lastName;
  String email;
  String password;
  int? rank;
  double? moneySpent;
  double? moneyReceived;
  int? profileImage;
  List<Group>? groupList;
  List<Expense>? expenceList;

  User(
      {required this.userName,
      required this.name,
      required this.lastName,
      required this.email,
      required this.password,
        this.id,
      this.profileImage,
      this.rank,
      this.groupList,
      this.moneyReceived,
      this.moneySpent,
      this.expenceList});
}

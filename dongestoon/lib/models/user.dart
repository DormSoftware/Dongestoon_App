
import 'package:dongestoon/models/group.dart';
import 'package:dongestoon/models/transaction.dart';

class User {
  String id;
  String name;
  int? rank;
  double? moneySpent;
  double? moneyReceived;
  int? profileImage;
  List<Group>? groupList;
  List<Transaction>? transactionList;

  User(
      {required this.id,
      required this.name,
      this.profileImage,
       this.rank,
      this.groupList,
      this.moneyReceived,
      this.moneySpent,
      this.transactionList});
}

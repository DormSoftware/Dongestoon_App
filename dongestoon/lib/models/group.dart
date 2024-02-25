import 'package:dongestoon/models/user.dart';

class Group {
  String? id;
  String name;
  List<String> userList;
  int? profilePic;
  double? totalCost;
  double? rank;

  Group(
      {this.id,
      required this.name,
      required this.userList,
      this.totalCost,
      this.profilePic,
      this.rank});
}

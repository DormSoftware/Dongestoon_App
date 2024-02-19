
import 'package:dongestoon/models/user.dart';

class Group {
  String id;
  String name;
  List<User>? members;
  int? profilePic;
  double? totalCost;
  double? rank;

  Group(
      {required this.id,
      required this.name,
      this.totalCost,
      this.profilePic,
      this.members,
      this.rank});
}

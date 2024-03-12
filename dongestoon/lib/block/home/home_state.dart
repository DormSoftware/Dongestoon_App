part of '../../block/home/home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}
class HomeLoading extends HomeState{}

class UserLoginSuccess extends HomeState {
  final User user;
  UserLoginSuccess(this.user);
}
class HomeFetchDataSuccess extends HomeState{
  final List<Group> groupList;
  HomeFetchDataSuccess(this.groupList);
}

class SelectNotification extends HomeState{
  final int index;
  SelectNotification(this.index);
}

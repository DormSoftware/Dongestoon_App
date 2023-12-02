part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class UserLoginSuccess extends HomeState {
  final User user;
  UserLoginSuccess(this.user);
}

part of 'startup_cubit.dart';

@immutable
abstract class StartupState {}

class StartupInitial extends StartupState {}

class StartUpLoading extends StartupState {}

class StartUpLoginApproved extends StartupState{
  final String token;
  StartUpLoginApproved(this.token);
}

class StartUpLoginDisapproved extends StartupState{}




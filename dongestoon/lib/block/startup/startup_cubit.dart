import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'startup_state.dart';

class StartupCubit extends Cubit<StartupState> {
  StartupCubit() : super(StartupInitial());
  Future<void> checkUserIsLogged(BuildContext context) async {
    emit(StartUpLoading());
    var prefs = await SharedPreferences.getInstance();
    String? token = await prefs.getString("token");
    if( token != null){
      emit(StartUpLoginApproved(token));
    }
    else{
      emit(StartUpLoginDisapproved());
    }
  }
}

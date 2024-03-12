import 'package:dongestoon/temp_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/group.dart';
import '../../models/user.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  Future<void> fetchUserData(String token) async {
    emit(
      UserLoginSuccess(
        User(
            name: "مهدی مظاهری تهرانی",
            groupList: tempGroupList,
            rank: 0,
            expenceList: tempExpenseList, userName: '', lastName: '', email: '', password: '',
        ),
      ),
    );
  }
  Future<void> homeInitial() async{
    emit(HomeInitial());
  }
  Future<void> fetchGroupList() async{
   // var result = BackendConnection.get("/Group", body);
  }

  Future<void> selectNotificationItem(int index) async {
    emit(SelectNotification(index));
  }



  HomeCubit() : super(HomeInitial());
}

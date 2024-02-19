import 'package:dongestoon/temp_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/user.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  Future<void> fetchUserData() async {
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

  Future<void> selectNotificationItem(int index) async {
    emit(SelectNotification(index));
  }



  HomeCubit() : super(HomeInitial());
}

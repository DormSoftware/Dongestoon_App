import 'package:dongestoon/temp_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../models/user.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {

  Future<void> fetchBarDiagramDataList() async {
    emit(UserLoginSuccess(User(id: "00", name: "مهدی مظاهری تهرانی",groupList: tempGroupList,rank: 0)));
  }
    HomeCubit() : super(HomeInitial());
}
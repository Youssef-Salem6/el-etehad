import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:el_etehad/core/paths/apis.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
part 'get_home_data_state.dart';

class GetHomeDataCubit extends Cubit<GetHomeDataState> {
  GetHomeDataCubit() : super(GetHomeDataInitial());
  Map data = {};
  getHomeData() async {
    emit(GetHomeDataLoading());
    try {
      var response = await http.get(Uri.parse(homeApiUrl));
      if (response.statusCode == 200) {
        emit(GetHomeDataSuccess());
        data = jsonDecode(response.body)["data"];
        print("Data get successfully");
      } else {
        emit(GetHomeDataFailure(msg: "can`t load home"));
      }
    } catch (e) {
      emit(GetHomeDataFailure(msg: e.toString()));
    }
  }
}

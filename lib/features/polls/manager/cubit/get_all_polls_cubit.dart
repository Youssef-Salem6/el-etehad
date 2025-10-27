import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:el_etehad/core/paths/apis.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
part 'get_all_polls_state.dart';

class GetAllPollsCubit extends Cubit<GetAllPollsState> {
  GetAllPollsCubit() : super(GetAllPollsInitial());
  List polls = [];
  getAllPolls() async {
    emit(GetAllPollsLoading());
    try {
      var response = await http.get(Uri.parse(getAllPollsUrl));
      if (response.statusCode == 200) {
        polls = jsonDecode(response.body)["data"];
        emit(GetAllPollsSuccess());
        print("success polls");
      } else {
        emit(GetAllPollsFailure());
      }
    } catch (e) {
      emit(GetAllPollsFailure());
    }
  }
}

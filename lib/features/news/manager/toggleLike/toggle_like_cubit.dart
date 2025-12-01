import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:el_etehad/core/paths/apis.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
part 'toggle_like_state.dart';

class ToggleLikeCubit extends Cubit<ToggleLikeState> {
  ToggleLikeCubit() : super(ToggleLikeInitial());
  toggleLike({required int id}) async {
    emit(ToggleLikeLoading());
    try {
      var respose = await http.post(
        Uri.parse('$getNewsDetailsUrl/$id/likes/toggle'),
      );
      if (respose.statusCode == 200) {
        emit(
          ToggleLikeSuccess(isLiked: jsonDecode(respose.body)["data"]["liked"]),
        );
      } else {
        emit(ToggleLikeFailure());
      }
    } catch (e) {
      emit(ToggleLikeFailure());
    }
  }
}

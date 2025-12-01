import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:el_etehad/core/paths/apis.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
part 'get_all_comments_state.dart';

class GetAllCommentsCubit extends Cubit<GetAllCommentsState> {
  GetAllCommentsCubit() : super(GetAllCommentsInitial());
  List comments = [];
  getComments({required int articalId}) async {
    emit(GetAllCommentsLoading());
    try {
      var response = await http.get(
        Uri.parse("$getNewsDetailsUrl/$articalId/comments"),
      );
      if (response.statusCode == 200) {
        comments = jsonDecode(response.body)["data"];
        emit(GetAllCommentsSuccess(comments: comments));
      }
    } catch (e) {
      emit(GetAllCommentsFailure());
    }
  }
}

import 'package:bloc/bloc.dart';
import 'package:el_etehad/core/paths/apis.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
part 'add_comment_state.dart';

class AddCommentCubit extends Cubit<AddCommentState> {
  AddCommentCubit() : super(AddCommentInitial());
  addComment({required String articalId, required String comment}) async {
    emit(AddCommentLoading());
    try {
      var response = await http.post(
        Uri.parse("$getNewsDetailsUrl/$articalId/comments"),
        body: {"comment": comment, "parent_id": ""},
      );
      if (response.statusCode == 201) {
        emit(AddCommentSuccess());
      } else {
        emit(AddCommentFailure(message: "Failed to add comment"));
      }
    } catch (e) {
      emit(AddCommentFailure(message: e.toString()));
    }
  }
}

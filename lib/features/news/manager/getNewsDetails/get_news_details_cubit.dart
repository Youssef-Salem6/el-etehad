import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:el_etehad/core/paths/apis.dart';
import 'package:el_etehad/features/news/models/news_details_model.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
part 'get_news_details_state.dart';

class GetNewsDetailsCubit extends Cubit<GetNewsDetailsState> {
  GetNewsDetailsCubit() : super(GetNewsDetailsInitial());

  NewsDetailsModel? newsDetailsModel; // Make it nullable

  getNewsDetails({required int id}) async {
    print("start");
    emit(GetNewsDetailsLoading());
    print("loading");
    try {
      var response = await http.get(Uri.parse("$getNewsDetailsUrl/$id"));
      if (response.statusCode == 200) {
        print(jsonDecode(response.body)["data"]);
        newsDetailsModel = NewsDetailsModel.fromJson(
          json: jsonDecode(response.body)["data"],
        );
        emit(GetNewsDetailsSuccess(newsDetailsModel: newsDetailsModel!));
      } else {
        emit(GetNewsDetailsFailure(message: "data failure"));
      }
    } catch (e) {
      emit(GetNewsDetailsFailure(message: "error is $e"));
    }
  }
}

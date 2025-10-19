// get_current_cubit.dart

import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:el_etehad/core/paths/apis.dart';
import 'package:el_etehad/fetures/services/models/currency_model.dart';
import 'package:meta/meta.dart';
import "package:http/http.dart" as http;

part 'get_current_state.dart';

class GetCurrentCubit extends Cubit<GetCurrentState> {
  GetCurrentCubit() : super(GetCurrentInitial());

  Future<void> getCurrent() async {
    emit(GetCurrentLoading());
    try {
      var response = await http.get(Uri.parse(currentApi));
      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final currencyModel = CurrencyModel.fromJson(jsonData);
        emit(GetCurrentSuccess(currencyModel: currencyModel));
      } else {
        emit(GetCurrentFailure(error: 'Failed to load currencies'));
      }
    } catch (e) {
      emit(GetCurrentFailure(error: e.toString()));
    }
  }
}

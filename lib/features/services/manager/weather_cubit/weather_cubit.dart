import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(WeatherInitial());
  getWeather({required double lat, required double long}) async {
    emit(WeatherLoading());
    try {
      String key = "8d5e0139730d4de29d4154019252710";
      var response = await http.get(
        Uri.parse(
          "http://api.weatherapi.com/v1/forecast.json?key=$key&q=$lat,$long&days=1&aqi=no&alerts=no&lang=Ar",
        ),
      );
      if (response.statusCode == 200) {
        Map data = jsonDecode(response.body);
        emit(WeatherSuccess(data: data));
      } else {
        emit(WeatherFailure());
      }
    } catch (e) {
      emit(WeatherFailure());
    }
  }
}

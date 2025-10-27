import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:el_etehad/features/services/models/prayer_times_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
part 'prayer_time_state.dart';

class PrayerTimeCubit extends Cubit<PrayerTimeState> {
  PrayerTimeCubit() : super(PrayerTimeInitial());

  getTimes({required String latitude, required String longtude}) async {
    emit(PrayerTimeLoading());
    try {
      // ignore: unused_local_variable
      bool serviceEnabled;
      LocationPermission permission;
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.whileInUse) {
        Position position = await Geolocator.getCurrentPosition();
        latitude = position.latitude.toString();
        longtude = position.longitude.toString();
      }
      String baseUrl = "http://api.aladhan.com/v1/timings";
      String date = DateFormat("d-M-y").format(DateTime.now());
      Uri url = Uri.parse(
        "$baseUrl/$date?latitude=$latitude&longitude=$longtude",
      );
      http.Response response = await http.get(url);
      Map<String, dynamic> data = jsonDecode(response.body);
      PrayerTimesModel prayerTimesModel = PrayerTimesModel.fromJson(
        jsonData: data,
      );
      emit(PrayerTimeSuccess(prayerTimesModel: prayerTimesModel));
    } on Exception {
      emit(PrayerTimeFailure());
    }
  }
}

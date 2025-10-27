import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:geolocator/geolocator.dart';

part 'get_location_state.dart';

class GetLocationCubit extends Cubit<GetLocationState> {
  GetLocationCubit() : super(GetLocationInitial());

  Future<void> getLocation() async {
    emit(GetLocationLoading());

    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        emit(GetLocationFailure(error: 'Location services are disabled'));
        return;
      }

      // Check location permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          emit(GetLocationFailure(error: 'Location permission denied'));
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        emit(GetLocationFailure(
            error: 'Location permissions are permanently denied'));
        return;
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      emit(GetLocationSuccess(
        latitude: position.latitude,
        longitude: position.longitude,
      ));
    } catch (e) {
      emit(GetLocationFailure(error: e.toString()));
    }
  }

  // Optional: Get location with custom accuracy
  Future<void> getLocationWithAccuracy(LocationAccuracy accuracy) async {
    emit(GetLocationLoading());

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        emit(GetLocationFailure(error: 'Location services are disabled'));
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          emit(GetLocationFailure(error: 'Location permission denied'));
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        emit(GetLocationFailure(
            error: 'Location permissions are permanently denied'));
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: accuracy,
      );

      emit(GetLocationSuccess(
        latitude: position.latitude,
        longitude: position.longitude,
      ));
    } catch (e) {
      emit(GetLocationFailure(error: e.toString()));
    }
  }
}


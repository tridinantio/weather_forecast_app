import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:weather_forecast_app/utils/app_permission_handler.dart';
import 'package:weather_forecast_app/utils/get_location.dart';

part 'fix_location_state.dart';

class FixLocationCubit extends Cubit<FixLocationState> {
  FixLocationCubit() : super(FixLocationInitial());

  Future<void> fetchLocation() async {
    try {
      emit(FixLocationLoading());
      AppPermissionHandler().getLocationPermission().then((value) => value ==
              true
          ? GetLocation()
              .fetchLocation()
              .then((value) => emit(FixLocationSuccess(locationDetail: value)))
          : emit(FixLocationNotGranted()));
    } catch (e) {
      emit(FixLocationFailed(error: e.toString()));
    }
  }
}

import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:weather_forecast_app/shared/model/weather_forecast_model.dart';
import 'package:weather_forecast_app/feature/my_weather/service/fetch_weather.dart';
import 'package:weather_forecast_app/utils/shared_preference_service.dart';

part 'my_weather_state.dart';

class MyWeatherCubit extends Cubit<MyWeatherState> {
  MyWeatherCubit() : super(MyWeatherInitial());

  Future<void> fetchWeatherData(String lat, String long) async {
    try {
      emit(MyWeatherLoading());
      if (await InternetConnectionChecker().hasConnection) {
        log("Fetch Weather Data");

        WeatherForecastModel weatherData =
            await FetchWeater().fetchWeather(lat, long);
        log("SUCCESS CONVERT JSON");
        emit(MyWeatherSuccess(weatherData: weatherData));
        SharedPreferencService().saveWeatherData(weatherData);
      } else {
        emit(MyWeatherOffline());
      }
    } catch (e) {
      emit(MyWeatherFailed(message: e.toString()));
    }
  }
}

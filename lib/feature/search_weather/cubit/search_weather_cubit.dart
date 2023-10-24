import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_forecast_app/feature/search_weather/service/search_weather.dart';
import 'package:weather_forecast_app/shared/model/weather_forecast_model.dart';

part 'search_weather_state.dart';

class SearchWeatherCubit extends Cubit<SearchWeatherState> {
  SearchWeatherCubit() : super(SearchWeatherInitial());

  Future<void> fetchWeatherData(String city) async {
    try {
      emit(SearchWeatherLoading());
      log("Fetch Weather Data");

      WeatherForecastModel weatherData =
          await SearchWeater().searchWeather(city);
      log("SUCCESS CONVERT JSON");
      emit(SearchWeatherSuccess(weatherData: weatherData));
      // emit(SearchWeatherSuccess(weatherData: weatherData));
    } catch (e) {
      emit(SearchWeatherFailed(message: e.toString()));
    }
  }
}

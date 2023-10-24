import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_forecast_app/shared/model/weather_forecast_model.dart';

class SharedPreferencService {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  void saveWeatherData(WeatherForecastModel weatherData) async {
    SharedPreferences pref = await _prefs;
    pref.setString('weatherData', jsonEncode(weatherData));
    log('Data berhasil disave : $weatherData');
  }

  getWeatherData() async {
    SharedPreferences pref = await _prefs;
    return json.decode(pref.getString('weatherData') ?? "");
  }
}

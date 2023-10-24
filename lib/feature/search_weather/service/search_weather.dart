import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:weather_forecast_app/constant/api_key.dart';
import 'package:weather_forecast_app/shared/model/weather_forecast_model.dart';

class SearchWeater {
  Future<WeatherForecastModel> searchWeather(String city) async {
    var url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/forecast?q=$city&units=metric&appid=$weatherApiKey");
    Response response;
    response = await Dio().get(url.toString());

    var decodedResponse = jsonDecode(response.toString());

    log(response.toString());
    WeatherForecastModel weatherData =
        WeatherForecastModel.fromJson(decodedResponse);
    return weatherData;
    // The below request is the same as above.
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_forecast_app/shared/model/weather_forecast_model.dart';
import 'package:weather_forecast_app/theme_manager/font_manager.dart';
import 'package:weather_forecast_app/theme_manager/style_manager.dart';

class WeatherDetails extends StatelessWidget {
  const WeatherDetails({Key? key, required this.weatherData}) : super(key: key);

  final ListElement weatherData;

  @override
  Widget build(BuildContext context) {
    DateTime formattedDate = DateTime.parse(weatherData.dtTxt.toString());
    String finalDate = DateFormat('EEEE, d MMMM, y').format(formattedDate);
    String finalTime = DateFormat('h:mm a').format(formattedDate);

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 24,
            ),
            Text(
              finalDate,
              overflow: TextOverflow.fade,
              style: getBlackTextStyle().copyWith(
                  fontWeight: FontWeightManager.bold,
                  fontSize: FontSizeManager.f22),
            ),
            Text(
              finalTime,
              overflow: TextOverflow.fade,
              style: getBlackTextStyle().copyWith(
                  fontWeight: FontWeightManager.regular,
                  fontSize: FontSizeManager.f18),
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "${weatherData.main!.temp}\u00B0C",
                  style: getBlackTextStyle().copyWith(
                      fontSize: FontSizeManager.f44,
                      fontWeight: FontWeightManager.bold),
                ),
                const SizedBox(
                  width: 10,
                ),
                CachedNetworkImage(
                  imageUrl:
                      "https://openweathermap.org/img/wn/${weatherData.weather![0].icon}.png",
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              "${weatherData.weather![0].main!} (${weatherData.weather![0].description!})",
              style: getBlackTextStyle().copyWith(
                  fontSize: FontSizeManager.f22,
                  fontWeight: FontWeightManager.medium),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      "Temp(min)",
                      style: getBlackTextStyle().copyWith(
                          fontSize: FontSizeManager.f22,
                          fontWeight: FontWeightManager.regular),
                    ),
                    Text(
                      "${weatherData.main!.tempMin}\u00B0C",
                      style: getBlackTextStyle().copyWith(
                          fontSize: FontSizeManager.f22,
                          fontWeight: FontWeightManager.regular),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "Temp(max)",
                      style: getBlackTextStyle().copyWith(
                          fontSize: FontSizeManager.f22,
                          fontWeight: FontWeightManager.regular),
                    ),
                    Text(
                      "${weatherData.main!.tempMax}\u00B0C",
                      style: getBlackTextStyle().copyWith(
                          fontSize: FontSizeManager.f22,
                          fontWeight: FontWeightManager.regular),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

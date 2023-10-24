import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:weather_forecast_app/shared/model/weather_forecast_model.dart';
import 'package:weather_forecast_app/theme_manager/font_manager.dart';
import 'package:weather_forecast_app/theme_manager/style_manager.dart';

class SearchWeatherDataWidget extends StatelessWidget {
  const SearchWeatherDataWidget({Key? key, required this.currentWeatherData})
      : super(key: key);
  final ListElement currentWeatherData;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CachedNetworkImage(
          imageUrl:
              "https://openweathermap.org/img/wn/${currentWeatherData.weather![0].icon}.png",
          height: 100,
          width: 100,
          fit: BoxFit.cover,
        ),
        const SizedBox(
          width: 10,
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${currentWeatherData.main!.temp}\u00B0C",
                style: getBlack60TextStyle().copyWith(
                    fontSize: FontSizeManager.f44,
                    fontWeight: FontWeightManager.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                currentWeatherData.weather![0].main!,
                style: getBlack60TextStyle().copyWith(
                    fontSize: FontSizeManager.f22,
                    fontWeight: FontWeightManager.regular),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

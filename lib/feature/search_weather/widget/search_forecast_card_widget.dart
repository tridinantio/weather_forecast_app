import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_forecast_app/shared/model/weather_forecast_model.dart';
import 'package:weather_forecast_app/shared/view/weather_details.dart';
import 'package:weather_forecast_app/theme_manager/color_manager.dart';
import 'package:weather_forecast_app/theme_manager/font_manager.dart';
import 'package:weather_forecast_app/theme_manager/style_manager.dart';
import 'package:weather_forecast_app/theme_manager/values_manager.dart';

class SearchForecastCardWidget extends StatelessWidget {
  const SearchForecastCardWidget({Key? key, required this.forecastday})
      : super(key: key);
  final ListElement forecastday;

  @override
  Widget build(BuildContext context) {
    DateTime formattedDate = DateTime.parse(forecastday.dtTxt.toString());
    String finalDate =
        DateFormat('EE, d MMMM, y, h:mm a').format(formattedDate); //
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    WeatherDetails(weatherData: forecastday)));
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: ColorManager.grey60))),
        padding:
            const EdgeInsets.symmetric(vertical: AppPadding.p12, horizontal: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl:
                  "https://openweathermap.org/img/wn/${forecastday.weather![0].icon}.png",
              height: 60,
              width: 60,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              width: 8,
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    finalDate,
                    overflow: TextOverflow.fade,
                    style: getBlackTextStyle().copyWith(
                        fontWeight: FontWeightManager.bold,
                        fontSize: FontSizeManager.f18),
                  ),
                  Text(
                    forecastday.weather![0].main!,
                    overflow: TextOverflow.fade,
                    style: getBlackTextStyle().copyWith(
                        fontWeight: FontWeightManager.medium,
                        fontSize: FontSizeManager.f18),
                  ),
                  Text(
                    "Temp: ${forecastday.main!.temp}\u00B0C",
                    style: getBlack60TextStyle().copyWith(
                        fontSize: FontSizeManager.f18,
                        fontWeight: FontWeightManager.regular),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

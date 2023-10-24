import 'package:flutter/material.dart';
import 'package:weather_forecast_app/shared/model/weather_forecast_model.dart';
import 'package:weather_forecast_app/feature/my_weather/widget/city_and_date_widget.dart';
import 'package:weather_forecast_app/feature/my_weather/widget/forecast_card_widget.dart';
import 'package:weather_forecast_app/feature/my_weather/widget/weather_data_widget.dart';
import 'package:weather_forecast_app/theme_manager/style_manager.dart';

class OfflineWeatherWidget extends StatelessWidget {
  const OfflineWeatherWidget({Key? key, required this.offlineWeatherData})
      : super(key: key);
  final WeatherForecastModel offlineWeatherData;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 50,
          ),
          Text(
            "SHOWING LATEST SAVED OFFLINE DATA",
            style: getBlack60TextStyle(),
          ),
          const SizedBox(
            height: 20,
          ),
          CityAndDateWidget(
            city: offlineWeatherData.city!,
          ),
          const SizedBox(
            height: 40,
          ),
          WeatherDataWidget(
            currentWeatherData: offlineWeatherData.list![0],
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
            children: offlineWeatherData.list!.map((data) {
              //REMOVE NOW DATE/CURRENT DATE
              DateTime currentDate = DateTime.now();
              DateTime dataDate = data.dtTxt!;
              String formattedCurrentDate =
                  "${currentDate.year}-${currentDate.month}-${currentDate.day}";
              String formattedDataDate =
                  "${dataDate.year}-${dataDate.month}-${dataDate.day}";

              return formattedCurrentDate == formattedDataDate
                  ? const SizedBox()
                  : ForecastCardWidget(
                      forecastday: data,
                    );
            }).toList(),
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}

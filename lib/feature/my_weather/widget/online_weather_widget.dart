import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_forecast_app/feature/my_weather/cubit/my_weather_cubit.dart';
import 'package:weather_forecast_app/shared/model/weather_forecast_model.dart';
import 'package:weather_forecast_app/feature/my_weather/widget/city_and_date_widget.dart';
import 'package:weather_forecast_app/feature/my_weather/widget/forecast_card_widget.dart';
import 'package:weather_forecast_app/feature/my_weather/widget/weather_data_widget.dart';
import 'package:weather_forecast_app/feature/search_weather/view/search_weather_screen.dart';
import 'package:weather_forecast_app/theme_manager/style_manager.dart';

class OnlineWeatherWidget extends StatefulWidget {
  const OnlineWeatherWidget(
      {Key? key,
      required this.weatherData,
      required this.lat,
      required this.long})
      : super(key: key);
  final WeatherForecastModel weatherData;

  final String lat;

  final String long;

  @override
  State<OnlineWeatherWidget> createState() => _OnlineWeatherWidgetState();
}

class _OnlineWeatherWidgetState extends State<OnlineWeatherWidget> {
  final TextEditingController _searchWordController = TextEditingController();
  WeatherForecastModel? offlineWeatherData;

  @override
  Widget build(BuildContext context) {
    Future<void> refreshWeather() async {
      context.read<MyWeatherCubit>().fetchWeatherData(widget.lat, widget.long);
    }

    return RefreshIndicator.adaptive(
      onRefresh: refreshWeather,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 50,
            ),
            SearchBar(
              controller: _searchWordController,
              hintText: 'Search weather from other city',
              hintStyle: MaterialStateProperty.all(
                getBlackTextStyle(),
              ),
              trailing: [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    if (_searchWordController.text.isNotEmpty) {
                      Navigator.pushNamed(
                          context, SearchWeatherScreen.routeName,
                          arguments: _searchWordController.text);
                      _searchWordController.clear();
                    }
                  },
                ),
              ],
              onSubmitted: (value) {
                Navigator.pushNamed(context, SearchWeatherScreen.routeName,
                    arguments: value);
                _searchWordController.clear();
              },
            ),
            const SizedBox(
              height: 20,
            ),
            CityAndDateWidget(
              city: widget.weatherData.city!,
            ),
            const SizedBox(
              height: 40,
            ),
            WeatherDataWidget(
              currentWeatherData: widget.weatherData.list![0],
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              children: widget.weatherData.list!.map((data) {
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
      ),
    );
  }
}

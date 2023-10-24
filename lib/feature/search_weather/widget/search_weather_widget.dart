import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_forecast_app/feature/search_weather/cubit/search_weather_cubit.dart';
import 'package:weather_forecast_app/feature/search_weather/widget/search_city_and_date_widget.dart';
import 'package:weather_forecast_app/feature/search_weather/widget/search_forecast_card_widget.dart';
import 'package:weather_forecast_app/feature/search_weather/widget/search_weather_data_widget.dart';

class SearchWeatherWidget extends StatefulWidget {
  const SearchWeatherWidget({Key? key, required this.city}) : super(key: key);
  final String city;

  @override
  State<SearchWeatherWidget> createState() => _SearchWeatherWidgetState();
}

class _SearchWeatherWidgetState extends State<SearchWeatherWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // FETCH WEATHER DATA FROM API
    log("CITY : ${widget.city}");
    context.read<SearchWeatherCubit>().fetchWeatherData(widget.city);
  }

  Future<void> refreshWeather() async {
    context.read<SearchWeatherCubit>().fetchWeatherData(widget.city);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchWeatherCubit, SearchWeatherState>(
      builder: (context, state) {
        if (state is SearchWeatherLoading) {
          log("masuk loading ");
          return const Center(child: CircularProgressIndicator.adaptive());
        } else if (state is SearchWeatherSuccess) {
          log("masuk success");
          return RefreshIndicator.adaptive(
            onRefresh: refreshWeather,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  SearchCityAndDateWidget(
                    city: state.weatherData.city!,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  SearchWeatherDataWidget(
                    currentWeatherData: state.weatherData.list![0],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: state.weatherData.list!.map((data) {
                      //REMOVE NOW DATE/CURRENT DATE
                      DateTime currentDate = DateTime.now();
                      DateTime dataDate = data.dtTxt!;
                      String formattedCurrentDate =
                          "${currentDate.year}-${currentDate.month}-${currentDate.day}";
                      String formattedDataDate =
                          "${dataDate.year}-${dataDate.month}-${dataDate.day}";

                      return formattedCurrentDate == formattedDataDate
                          ? const SizedBox()
                          : SearchForecastCardWidget(
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
        } else {
          log("masuk else$state");
          return const Center(
            child: Text("Sorry, city not found"),
          );
        }
      },
    );
  }
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_forecast_app/feature/my_weather/cubit/my_weather_cubit.dart';
import 'package:weather_forecast_app/shared/model/weather_forecast_model.dart';
import 'package:weather_forecast_app/feature/my_weather/widget/offline_weather_widget.dart';
import 'package:weather_forecast_app/feature/my_weather/widget/online_weather_widget.dart';
import 'package:weather_forecast_app/theme_manager/style_manager.dart';
import 'package:weather_forecast_app/utils/shared_preference_service.dart';

class MainWeatherWidget extends StatefulWidget {
  const MainWeatherWidget({Key? key, required this.lat, required this.long})
      : super(key: key);
  final String lat;
  final String long;

  @override
  State<MainWeatherWidget> createState() => _OnlineWeatherWidgetState();
}

class _OnlineWeatherWidgetState extends State<MainWeatherWidget> {
  WeatherForecastModel? offlineWeatherData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (offlineWeatherData == null) {
      log("offline data is null");
    }

    // FETCH WEATHER DATA FROM API
    context.read<MyWeatherCubit>().fetchWeatherData(widget.lat, widget.long);
  }

  Future<void> refreshWeather() async {
    context.read<MyWeatherCubit>().fetchWeatherData(widget.lat, widget.long);
  }

  Future<void> geOfflinetWeatherData() async {
    try {
      WeatherForecastModel weatherData = WeatherForecastModel.fromJson(
          await SharedPreferencService().getWeatherData());
      setState(() {
        offlineWeatherData = weatherData;
      });
    } catch (exception) {
      // do something
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MyWeatherCubit, MyWeatherState>(
      listener: (context, state) {
        if (state is MyWeatherOffline) {
          geOfflinetWeatherData();
        }
      },
      builder: (context, state) {
        if (state is MyWeatherLoading) {
          log("masuk loading ");
          return const Center(child: CircularProgressIndicator.adaptive());
        } else if (state is MyWeatherSuccess) {
          log("masuk success");
          return OnlineWeatherWidget(
              weatherData: state.weatherData,
              lat: widget.lat,
              long: widget.long);
        } else if (state is MyWeatherOffline) {
          return offlineWeatherData == null
              ? Center(
                  child: Text(
                    "You are completely offline from the beginning, hence no previous weather data is saved",
                    style: getBlack60TextStyle(),
                    textAlign: TextAlign.center,
                  ),
                )
              : OfflineWeatherWidget(
                  offlineWeatherData: offlineWeatherData!,
                );
        } else {
          log("masuk else$state");
          return const Center(child: CircularProgressIndicator.adaptive());
        }
      },
    );
  }
}

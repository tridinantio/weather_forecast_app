import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_forecast_app/feature/my_weather/widget/disabled_location_widget.dart';
import 'package:weather_forecast_app/feature/my_weather/widget/main_weather_widget.dart';
import 'package:weather_forecast_app/shared/cubit/fix_location_cubit.dart';
import 'package:weather_forecast_app/theme_manager/values_manager.dart';

class MyWeather extends StatefulWidget {
  static const String routeName = '/my-weather';
  const MyWeather({Key? key}) : super(key: key);

  @override
  State<MyWeather> createState() => _MyWeatherState();
}

class _MyWeatherState extends State<MyWeather> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p18),
        child: BlocBuilder<FixLocationCubit, FixLocationState>(
          builder: (context, state) {
            // TODO: implement listener
            if (state is FixLocationSuccess) {
              return MainWeatherWidget(
                  lat: state.locationDetail[0], long: state.locationDetail[1]);
            } else if (state is FixLocationNotGranted) {
              return const DisabledLocationWidget();
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}

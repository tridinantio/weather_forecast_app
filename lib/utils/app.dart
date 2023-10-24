import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_forecast_app/feature/my_weather/view/my_weather_screen.dart';
import 'package:weather_forecast_app/feature/search_weather/view/search_weather_screen.dart';
import 'package:weather_forecast_app/shared/cubit/fix_location_cubit.dart';
import 'package:weather_forecast_app/theme_manager/theme_data_manager.dart';

class AppScreen extends StatefulWidget {
  const AppScreen({
    super.key,
  });

  @override
  State<AppScreen> createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  @override
  void initState() {
    super.initState();
    // FETCH LOCATION FROM USER'S DEVICE
    context.read<FixLocationCubit>().fetchLocation();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: MyWeather.routeName,
      theme: getApplicationThemeData(),
      routes: {
        MyWeather.routeName: (context) => const MyWeather(),
        SearchWeatherScreen.routeName: (context) => const SearchWeatherScreen(),
      },
    );
  }
}

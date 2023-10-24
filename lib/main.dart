import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_forecast_app/feature/my_weather/cubit/my_weather_cubit.dart';
import 'package:weather_forecast_app/feature/search_weather/cubit/search_weather_cubit.dart';
import 'package:weather_forecast_app/shared/cubit/fix_location_cubit.dart';
import 'package:weather_forecast_app/utils/app.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MyWeatherCubit(),
        ),
        BlocProvider(
          create: (context) => FixLocationCubit(),
        ),
        BlocProvider(
          create: (context) => SearchWeatherCubit(),
        )
      ],
      child: const AppScreen(),
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_forecast_app/feature/auth/cubits/auth_cubit.dart';
import 'package:weather_forecast_app/feature/my_weather/cubit/my_weather_cubit.dart';
import 'package:weather_forecast_app/feature/search_weather/cubit/search_weather_cubit.dart';
import 'package:weather_forecast_app/firebase_options.dart';
import 'package:weather_forecast_app/shared/cubit/fix_location_cubit.dart';
import 'package:weather_forecast_app/utils/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

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
        ),
        BlocProvider(
          create: (context) => AuthCubit(),
        )
      ],
      child: const AppScreen(),
    );
  }
}

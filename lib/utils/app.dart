import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_forecast_app/feature/auth/cubits/auth_cubit.dart';
import 'package:weather_forecast_app/feature/auth/views/login_page.dart';
import 'package:weather_forecast_app/feature/auth/views/otp_page.dart';
import 'package:weather_forecast_app/feature/auth/views/register_page.dart';
import 'package:weather_forecast_app/feature/my_weather/view/my_weather_screen.dart';
import 'package:weather_forecast_app/feature/search_weather/view/search_weather_screen.dart';
import 'package:weather_forecast_app/shared/cubit/fix_location_cubit.dart';
import 'package:weather_forecast_app/theme_manager/theme_data_manager.dart';
import 'package:weather_forecast_app/utils/navigator_key.dart';

class AppScreen extends StatefulWidget {
  const AppScreen({
    super.key,
  });

  @override
  State<AppScreen> createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  bool isUserStillLoggedin = false;
  @override
  void initState() {
    super.initState();
    // FETCH LOCATION FROM USER'S DEVICE
    context.read<FixLocationCubit>().fetchLocation();
    context.read<AuthCubit>().checkUserToken();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
      return MaterialApp(
        navigatorKey: NavigatorKey.navigatorKey,
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: LoginPage.routeName,
        theme: getApplicationThemeData(),
        routes: {
          LoginPage.routeName: (context) => const LoginPage(),
          MyWeather.routeName: (context) => const MyWeather(),
          SearchWeatherScreen.routeName: (context) =>
              const SearchWeatherScreen(),
          RegisterPage.routeName: (context) => const RegisterPage(),
          OtpPage.routeName: (context) => const OtpPage(),
        },
      );
    });
  }
}

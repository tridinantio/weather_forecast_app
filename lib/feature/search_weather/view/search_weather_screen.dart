// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:weather_forecast_app/feature/search_weather/widget/search_weather_widget.dart';
import 'package:weather_forecast_app/theme_manager/values_manager.dart';

class SearchWeatherScreen extends StatefulWidget {
  static const String routeName = '/search-weather';
  const SearchWeatherScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchWeatherScreen> createState() => _SearchWeatherScreenState();
}

class _SearchWeatherScreenState extends State<SearchWeatherScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //READ ARGUMENTS FROM PREV PAGE
    final args = ModalRoute.of(context)!.settings.arguments;

    return Scaffold(
      body: Container(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p18),
          child: SearchWeatherWidget(
            city: args.toString(),
          )),
    );
  }
}

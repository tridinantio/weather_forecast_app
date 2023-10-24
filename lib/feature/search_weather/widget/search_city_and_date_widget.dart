// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_forecast_app/shared/model/weather_forecast_model.dart';
import 'package:weather_forecast_app/theme_manager/font_manager.dart';
import 'package:weather_forecast_app/theme_manager/style_manager.dart';

class SearchCityAndDateWidget extends StatelessWidget {
  final City city;
  const SearchCityAndDateWidget({
    Key? key,
    required this.city,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DateTime formattedDate = DateTime.parse(DateTime.now().toString());
    String finalDate = DateFormat('EEEE, d MMMM').format(formattedDate); //
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${city.name},',
          style: getBlackTextStyle().copyWith(
              fontWeight: FontWeightManager.medium,
              fontSize: FontSizeManager.f44),
        ),
        Text(
          city.country.toString(),
          style: getBlackTextStyle().copyWith(
              fontWeight: FontWeightManager.regular,
              fontSize: FontSizeManager.f28),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          finalDate,
          // location.localtime.toString(),
          style: getBlackTextStyle().copyWith(
              fontWeight: FontWeightManager.regular,
              fontSize: FontSizeManager.f22),
        ),
      ],
    );
  }
}

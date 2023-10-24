import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_forecast_app/shared/cubit/fix_location_cubit.dart';

class SearchDisabledLocationWidget extends StatelessWidget {
  const SearchDisabledLocationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text("Location permission is not granted"),
        TextButton(
            onPressed: () {
              context.read<FixLocationCubit>().fetchLocation();
            },
            child: const Text("Tap here to enable it"))
      ],
    );
  }
}

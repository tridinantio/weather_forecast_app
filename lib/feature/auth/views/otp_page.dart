import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinput/pinput.dart';
import 'package:weather_forecast_app/feature/auth/cubits/auth_cubit.dart';
import 'package:weather_forecast_app/feature/my_weather/view/my_weather_screen.dart';

class OtpPage extends StatelessWidget {
  const OtpPage({Key? key}) : super(key: key);
  static String routeName = "/otp-page";

  @override
  Widget build(BuildContext context) {
    TextEditingController pinController = TextEditingController();
    return WillPopScope(
      onWillPop: null,
      child: Scaffold(
        body: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Pinput(
                length: 6,
                keyboardType: TextInputType.number,
                controller: pinController,
                textInputAction: TextInputAction.done,
                showCursor: true,
                onCompleted: (pin) => context
                    .read<AuthCubit>()
                    .verifyOtp(pinController.text.trim()),
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                // TODO: implement listener
                if (state is AuthSuccess) {
                  Navigator.pushReplacementNamed(context, MyWeather.routeName);
                } else if (state is AuthWithPhone) {}
              },
              builder: (context, state) {
                if (state is AuthLoading) {
                  return const CircularProgressIndicator.adaptive();
                }
                return SizedBox(
                  width: MediaQuery.sizeOf(context).width / 2,
                  height: MediaQuery.sizeOf(context).height / 18,
                  child: ElevatedButton(
                    onPressed: () async {
                      context
                          .read<AuthCubit>()
                          .verifyOtp(pinController.text.trim());
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100)),
                      backgroundColor: const Color.fromARGB(255, 71, 140, 196),
                    ),
                    child: const Text("Verify"),
                  ),
                );
              },
            )
          ],
        )),
      ),
    );
  }
}

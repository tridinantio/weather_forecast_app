import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_forecast_app/feature/auth/cubits/auth_cubit.dart';
import 'package:weather_forecast_app/feature/auth/views/otp_page.dart';
import 'package:weather_forecast_app/feature/auth/views/register_page.dart';
import 'package:weather_forecast_app/feature/auth/widgets/custom_form.dart';
import 'package:weather_forecast_app/theme_manager/font_manager.dart';
import 'package:weather_forecast_app/theme_manager/style_manager.dart';

class LogInWithPhone extends StatelessWidget {
  const LogInWithPhone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController phoneController = TextEditingController();
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 22,
              ),
              Text(
                "LOG IN",
                style: getBlackTextStyle().copyWith(
                    fontWeight: FontWeightManager.medium,
                    fontSize: FontSizeManager.f44),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomForm(
                  textInputType: TextInputType.phone,
                  desc: "Please enter valid phone number",
                  hint: "Ex: 8129981982",
                  controller: phoneController),
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  // TODO: implement listener
                  if (state is AuthWithPhone) {
                    Navigator.pushReplacementNamed(context, OtpPage.routeName);
                  }
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
                        context.read<AuthCubit>().registerWithPhone(
                            phoneController.text.startsWith("0")
                                ? phoneController.text.substring(1)
                                : phoneController.text);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100)),
                        backgroundColor:
                            const Color.fromARGB(255, 71, 140, 196),
                      ),
                      child: const Text("Log In"),
                    ),
                  );
                },
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width / 2,
                height: MediaQuery.sizeOf(context).height / 18,
                child: TextButton(
                  onPressed: () async {
                    Navigator.pushNamed(context, RegisterPage.routeName);
                  },
                  child: const Text("Register"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

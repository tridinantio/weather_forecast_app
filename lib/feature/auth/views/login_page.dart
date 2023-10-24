import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_forecast_app/feature/auth/cubits/auth_cubit.dart';
import 'package:weather_forecast_app/feature/auth/views/register_page.dart';
import 'package:weather_forecast_app/feature/auth/widgets/custom_form.dart';
import 'package:weather_forecast_app/feature/my_weather/view/my_weather_screen.dart';
import 'package:weather_forecast_app/theme_manager/font_manager.dart';
import 'package:weather_forecast_app/theme_manager/style_manager.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);
  static String routeName = "/login-page";

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
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
              CustomForm(label: "", hint: "Email", controller: emailController),
              CustomForm(
                  label: "", hint: "Password", controller: passwordController),
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  // TODO: implement listener
                  if (state is AuthSuccess) {
                    Navigator.pushReplacementNamed(
                        context, MyWeather.routeName);
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
                        if (emailController.text.isNotEmpty &&
                            passwordController.text.isNotEmpty) {
                          if (EmailValidator.validate(emailController.text) &&
                              passwordController.text.length >= 8) {
                            context.read<AuthCubit>().logIn(
                                emailController.text, passwordController.text);
                          }
                        }
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
              const SizedBox(
                height: 18,
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width / 2,
                height: MediaQuery.sizeOf(context).height / 18,
                child: ElevatedButton(
                  onPressed: () async {
                    Navigator.pushNamed(context, RegisterPage.routeName);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100)),
                    backgroundColor: const Color.fromARGB(255, 71, 140, 196),
                  ),
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

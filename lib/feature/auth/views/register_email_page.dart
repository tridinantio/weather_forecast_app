import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_forecast_app/feature/auth/cubits/auth_cubit.dart';
import 'package:weather_forecast_app/feature/auth/widgets/custom_form.dart';
import 'package:weather_forecast_app/feature/my_weather/view/my_weather_screen.dart';
import 'package:weather_forecast_app/theme_manager/font_manager.dart';
import 'package:weather_forecast_app/theme_manager/style_manager.dart';

class RegisterEmailPage extends StatelessWidget {
  const RegisterEmailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const SizedBox(
              height: 22,
            ),
            Text(
              "REGISTER",
              style: getBlackTextStyle().copyWith(
                  fontWeight: FontWeightManager.medium,
                  fontSize: FontSizeManager.f44),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomForm(
              desc: "Please enter a valid email",
              hint: "Email",
              controller: emailController,
              textInputType: TextInputType.emailAddress,
            ),
            CustomForm(
              desc: "Password is 8 characters long",
              hint: "Password",
              controller: passwordController,
              textInputType: TextInputType.text,
            ),
            BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                // TODO: implement listener
                if (state is AuthSuccess) {
                  Navigator.pushReplacementNamed(context, MyWeather.routeName);
                } else if (state is AuthFailed) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Email already registered")));
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
                        if (passwordController.text.length < 8) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text(
                                      "Password must contain 8 characters")));
                        }
                        if (EmailValidator.validate(emailController.text) &&
                            passwordController.text.length >= 8) {
                          context.read<AuthCubit>().register(
                              emailController.text, passwordController.text);
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100)),
                      backgroundColor: const Color.fromARGB(255, 71, 140, 196),
                    ),
                    child: const Text("Register"),
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

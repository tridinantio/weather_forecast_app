import 'package:flutter/material.dart';
import 'package:weather_forecast_app/feature/auth/views/log_in_with_phone.dart';
import 'package:weather_forecast_app/feature/auth/views/log_with_email.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  static String routeName = "/login-page";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          forceMaterialTransparency: true,
          elevation: 0,
          backgroundColor: Colors.transparent,
          bottom: const TabBar(
            labelColor: Colors.black,
            unselectedLabelColor: Colors.white,
            tabs: [
              Tab(
                icon: Icon(
                  Icons.email,
                  color: Color.fromARGB(255, 69, 69, 69),
                ),
                text: "Email",
              ),
              Tab(
                icon: Icon(
                  Icons.phone,
                  color: Color.fromARGB(255, 69, 69, 69),
                ),
                text: "Phone",
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [LogInWithEmail(), LogInWithPhone()],
        ),
      ),
    );
  }
}

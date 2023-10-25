import 'package:flutter/material.dart';

import 'package:weather_forecast_app/feature/auth/views/register_email_page.dart';
import 'package:weather_forecast_app/feature/auth/views/register_phone_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);
  static String routeName = '/register-page';

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
          children: [RegisterEmailPage(), RegisterPhonePage()],
        ),
      ),
    );
  }
}

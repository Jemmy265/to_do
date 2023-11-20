import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/ui/Home_Screen/home_screen.dart';
import 'package:to_do/ui/login/Login_Screen.dart';

import '../../Providers/auth_provider.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = "Splash";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      checkLoggedInUser();
    });
    return Scaffold(
      body: Image.asset(
        "assets/images/splash.png",
        fit: BoxFit.fill,
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }

  void checkLoggedInUser() async {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    if (!authProvider.isUserLoggedInBefore()) {
      Navigator.pushReplacementNamed(context, LoginScreen.routename);
      return;
    }
    if (authProvider.isUserLoggedInBefore()) {
      await authProvider.autoLogin();
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    }
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:to_do/Providers/auth_provider.dart';
import 'package:to_do/firebase_options.dart';
import 'package:to_do/ui/Home_Screen/home_screen.dart';
import 'package:to_do/ui/login/Login_Screen.dart';
import 'package:to_do/ui/register/register_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: MyApp()));
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: FToastBuilder(),
      theme: ThemeData(
        textTheme: TextTheme(
          headlineMedium: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          )
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        ),
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Color(0xffDFECDB),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          elevation: 0,
          backgroundColor: Colors.transparent,
        )
      ),
      routes: {
        RegisterScreen.routeName : (buildContext)=>RegisterScreen(),
        LoginScreen.routename : (buildContext)=>LoginScreen(),
        HomeScreen.routeName : (buildContext)=>HomeScreen(),
      },
      initialRoute: RegisterScreen.routeName,
    );
  }
}


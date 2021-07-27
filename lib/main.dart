import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qask/constants/constants.dart';
import 'package:qask/ui/signin.dart';
import 'package:qask/ui/signup.dart';
import 'package:qask/ui/spinner.dart';
import 'package:qask/ui/splashscreen.dart';
import 'package:get/instance_manager.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    Get.put(SpinController());
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Login",
      theme: ThemeData(primaryColor: Colors.orange[200]),
      routes: <String, WidgetBuilder>{
        SPLASH_SCREEN: (BuildContext context) =>  SplashScreen(),
        SIGN_IN: (BuildContext context) =>  SignInPage(),
        SIGN_UP: (BuildContext context) =>  SignUpScreen(),
      },
      initialRoute: SPLASH_SCREEN,
    );
  }
}




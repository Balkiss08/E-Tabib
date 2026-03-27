import 'package:aya_medica/features/access%20management/enableLocation_screen.dart';
import 'package:aya_medica/features/access%20management/enableNotification_screen.dart';
import 'package:aya_medica/features/home_screen.dart';
import 'package:aya_medica/features/password/forgetPassword_screen.dart';
import 'package:aya_medica/features/login/emailVerification_screen.dart';
import 'package:aya_medica/features/login/login_screen.dart';
import 'package:aya_medica/features/onbarding/onBoarding_screen.dart';
import 'package:aya_medica/features/login/register_screen.dart';
import 'package:aya_medica/features/onbarding/splash_screen.dart';
import 'package:aya_medica/features/password/resetPassword_screen.dart';
import 'package:flutter/material.dart';

import 'features/password/passwordChangedSuccess_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: SplashScreen(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/home/home_page.dart';
import 'utils/constants/colors.dart';
import 'features/auth/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var email = sharedPreferences.getString("email");
  print(email);

  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: materialThemeData(),
      // home: const Login(),
      home: email == null ? const Login() : const HomePage(),
    ),
  );
}

ThemeData materialThemeData() {
  return ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.primaryColor,
    colorScheme: ColorScheme.dark(
      primary: AppColors.primaryColor,
      background: AppColors.darkBlue,
      secondary: AppColors.purple,
    ),
    useMaterial3: true,
  );
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_17_sharedpref/features/auth/login_page.dart';
import 'package:task_17_sharedpref/utils/constants/colors.dart';
import 'package:task_17_sharedpref/utils/shared/coustom_widgits.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var mediaWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              logOutButton(context, mediaWidth),
            ],
          ),
        ),
      ),
    );
  }

  void _logOutButton(BuildContext context) async {
    // Validate the form
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove("email");
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const Login()));
  }

  TextButton logOutButton(BuildContext context, mediaWidth) {
    return TextButton(
      onPressed: () => _logOutButton(context),
      style: TextButton.styleFrom(
        backgroundColor: AppColors.green,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(600)),
        minimumSize: Size(mediaWidth / 1.7, 70),
      ),
      child: Custom.text(
        text: "LogOut",
        textAlign: TextAlign.center,
        fontSize: 20,
        colors: AppColors.darkBlue,
        fontWeight: FontWeight.w700,
      ),
    );
  }
}

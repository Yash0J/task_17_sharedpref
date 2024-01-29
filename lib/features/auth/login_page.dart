import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_17_sharedpref/utils/shared/coustom_widgits.dart';
import '../../utils/constants/colors.dart';
import '../home/home_page.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String? validateUsername(String? username) {
    if (username == null || username.isEmpty) {
      return 'Username is required';
    } else if (!RegExp(r'^[a-zA-Z0-9._-]{2,10}$').hasMatch(username)) {
      return 'Invalid username format';
    }

    return null; // Username is valid
  }

  String? validateEmail(String? email) {
    if (email == null || email.isEmpty) {
      return 'Email is required';
    } else if (!RegExp(r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$')
        .hasMatch(email)) {
      return 'Invalid email format';
    }

    return null; // Email is valid
  }

  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password is required';
    } else if (!RegExp(r'^[a-zA-Z0-9!@#$%^&*]{6,16}$').hasMatch(password)) {
      return 'Invalid password format';
    }

    return null; // Password is valid
  }

  void login(String email, String password) async {
    try {
      http.Response response = await http.post(
        Uri.parse('https://reqres.in/api/login'),
        //login api integraded
        body: {
          // 'email': 'eve.holt@reqres.in',
          'email': email,
          // 'password': 'pistol',
          'password': password,
        },
      );

      String body = response.body; //assigning body as body response

      if (response.statusCode == 200) {
        //200 status code is for success
        // print('Account created successfully');
        var data = jsonDecode(body.toString());

        print("token for login is: ${data['token']}");
        print('login successfully');
        showSnackBar(context,
            'login successfully, \nemail is: $email \npassword is: $password \ntoken for login is: ${data['token']}');

        //adding shared prefrences
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setString("email", _emailController.text);
        //
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomePage()));
      } else {
        print('Login failed, status_code => ${response.statusCode}');
        showSnackBar(
            context, 'Login failed, \nstatus_code => ${response.statusCode}');
      }
    } catch (catchError) {
      print(catchError.toString());
      showSnackBar(context, 'Login Failed, \n${catchError.toString()}');
    }
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _loginButton() async {
    // Validate the form
    if (_formKey.currentState?.validate() == true) {
      print('Username: ${_usernameController.text}');
      print('Email: ${_emailController.text}');
      print('Password: ${_passwordController.text}');
    }
    login(
        _emailController.text.toString(), _passwordController.text.toString());
    // Navigator.of(context as BuildContext).push(MaterialPageRoute(builder: (context) => const HomePage()));
  }

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String? _usernameError;
  String? _emailError;
  String? _passwordError;

  @override
  Widget build(BuildContext context) {
    var mediaWidth = MediaQuery.of(context).size.width;

    var mediaHeight = MediaQuery.of(context).size.height;

    //
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: AppColors.darkBlue,
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 40),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //
                const SizedBox(height: 18),
                //
                loginImage(mediaHeight),
                //
                const SizedBox(height: 36),
                // const SizedBox(height: 18),
                //
                Custom.text(
                  text: "Login",
                  fontSize: 40,
                  fontWeight: FontWeight.w600,
                  // textAlign: TextAlign.left,
                ),
                //
                const SizedBox(height: 12),
                //
                Custom.text(
                  text: "Please sign in to continue",
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  // textAlign: TextAlign.left,
                ),
                //
                const SizedBox(height: 38),
                //
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      userNameTextField(),
                      //
                      emailTextField(),
                      //
                      passwordTextField(),
                    ],
                  ),
                ),
                //
                const SizedBox(height: 6),
                //
                loginButton(mediaWidth),
                //
                forgotPasswordButton(mediaWidth),
                //
                // SizedBox(height: mediaHeight * 0.1),

                //
                newAccountSignup(),
              ],
            ),
          ),
        ),
      ),
    );
  }

//
  Center loginImage(double mediaHeight) {
    return Center(
      child: SvgPicture.asset(
        'assets/icons/undraw_login.svg',
        height: mediaHeight * 0.18,
      ),
    );
  }

  SizedBox userNameTextField() {
    return SizedBox(
      height: 88,
      child: Column(
        children: [
          Custom.textField(
            validator: (value) {
              setState(() {
                _usernameError = validateUsername(value);
              });
              return null;
            },
            controller: _usernameController,
            cursorColor: AppColors.white,
            prefixIcon: const Icon(Icons.person), // Set the prefix icon
            hintText: 'Enter user name', // Placeholder text
            label: Custom.text(
              text: "User Name",
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          if (_usernameError != null)
            Text(
              _usernameError!,
              style: const TextStyle(color: Colors.red),
            ),
        ],
      ),
    );
  }

  SizedBox emailTextField() {
    return SizedBox(
      height: 88,
      child: Column(
        children: [
          Custom.textField(
            validator: (value) {
              setState(() {
                _emailError = validateUsername(value);
              });
              return null;
            },
            controller: _emailController,
            cursorColor: AppColors.white,
            prefixIcon: const Icon(Icons.email_outlined), // Set the prefix icon
            hintText: 'Enter your email', // Placeholder text
            label: Custom.text(
              text: "EMAIL",
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          if (_emailError != null)
            Text(
              _emailError!,
              style: const TextStyle(color: Colors.red),
            ),
        ],
      ),
    );
  }

  SizedBox passwordTextField() {
    return SizedBox(
      height: 88,
      child: Column(
        children: [
          Custom.textField(
            validator: (value) {
              setState(() {
                _passwordError = validateUsername(value);
              });
              return null;
            },
            controller: _passwordController,
            obscureText: true,
            hintText: 'Enter your password', // Placeholder text
            label: Custom.text(
              text: "PASSWORD",
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            cursorColor: AppColors.white,
            prefixIcon: const Icon(
              Icons.lock_outlined,
            ), // Set the prefix icon
          ),
          if (_passwordError != null)
            Text(
              _passwordError!,
              style: const TextStyle(color: Colors.red),
            ),
        ],
      ),
    );
  }

  TextButton loginButton(double mediaWidth) {
    return TextButton(
      onPressed: _loginButton,
      style: TextButton.styleFrom(
        backgroundColor: AppColors.green,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(600)),
        minimumSize: Size(mediaWidth / 1.7, 70),
      ),
      child: Custom.text(
        text: "LOGIN",
        textAlign: TextAlign.center,
        fontSize: 20,
        colors: AppColors.darkBlue,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  TextButton forgotPasswordButton(double mediaWidth) {
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(
        // backgroundColor: AppColors.green,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(600)),
        minimumSize: Size(mediaWidth / 9, 0),
        surfaceTintColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
      ),
      child: Custom.text(
        text: "Forgot Password?",
        textAlign: TextAlign.center,
        fontSize: 16,
        colors: AppColors.green,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget newAccountSignup() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Text.rich(
        textAlign: TextAlign.center,
        TextSpan(
          text: "Don't have an account? ",
          style: Custom.style(
            colors: AppColors.white.withOpacity(0.64),
          ),
          children: [
            WidgetSpan(
              child: Custom.text(
                text: "Sign up",
                colors: AppColors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///
}

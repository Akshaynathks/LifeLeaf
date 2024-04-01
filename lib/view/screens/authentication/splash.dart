import 'dart:async';
import 'package:flutter/material.dart';
import 'package:life_leaf/view/screens/authentication/landing_screens/landing_screen.dart';
import 'package:life_leaf/view/screens/home_screen/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkUserLoggedin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 114, 198, 112),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromARGB(255, 224, 248, 88),
          Color.fromARGB(255, 139, 240, 137)
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 90),
              child: Image(
                image: AssetImage('assets/logo lifeleaf.png'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> checkUserLoggedin() async {
    final sharedpref = await SharedPreferences.getInstance();
    final userloggedIn = sharedpref.getBool('userEntered');
    if (userloggedIn != null || userloggedIn == false) {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Home(),
          ));
    } else {
      // ignore: use_build_context_synchronously
      gotoLogin(context);
    }
  }

  Future<void> gotoLogin(context) async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LandingScreen(),
        ));
  }
}

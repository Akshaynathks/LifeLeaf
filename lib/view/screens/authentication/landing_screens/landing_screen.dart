import 'package:flutter/material.dart';
import 'package:life_leaf/view/screens/authentication/landing_screens/intro_one.dart';
import 'package:life_leaf/view/screens/authentication/landing_screens/intro_three.dart';
import 'package:life_leaf/view/screens/authentication/landing_screens/intro_two.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  // int _currentPage = 0;
  // final PageController _pageController = PageController();
  List<Widget> pages = [
    const IntroOne(),
    const IntroTwo(),
    const IntroThree(),
  ];

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;

    return Scaffold(
      body: LiquidSwipe(enableLoop: false, pages: pages),
    );
  }
}

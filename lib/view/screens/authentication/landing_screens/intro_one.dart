import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class IntroOne extends StatelessWidget {
  const IntroOne({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // List<Widget> pages = [];
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
              Color.fromARGB(255, 224, 248, 88),
              Color.fromARGB(255, 139, 240, 137)
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
            child: Column(
              children: [
                const SizedBox(
                  height: 60,
                ),
                const SizedBox(
                  height: 70,
                ),
                const Image(
                    image: AssetImage('assets/output-onlinepngtools (3).png')),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: 300,
                        child: Animate(
                          effects: [FadeEffect(duration: 1000.ms),const SlideEffect(curve:Curves.easeIn)],
                          child: const Text(
                            '"The secret of your future is hidden in your daily routine.","Time is what we want most, but what we use worst."',
                            style: TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                                fontFamily: 'Courier'),
                          ),
                        )),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: size.height * 0.9,
            left: size.width * 0.1,
            child: SizedBox(
              width: size.width * 0.8,
              child: Row(
                children: [
                  Animate(
                    effects: [FadeEffect(duration: 1000.ms),const SlideEffect(curve:Curves.easeIn),const FlipEffect(curve: Curves.easeIn)],
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, 'welcome');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 5.0,
                      ),
                      child: const Text(
                        'Skip',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    'swipe->',
                    style: TextStyle(
                        fontFamily: 'Courier',
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

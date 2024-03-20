import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class IntroThree extends StatelessWidget {
  const IntroThree({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
                SizedBox(
                  height: 150,
                ),
                Container(
                    width: size.width * 0.9,
                    child: Image(
                        image: AssetImage('assets/output-onlinepngtools.png'))),
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width: 300,
                        child: Text(
                          '"In the pursuit of your dreams, set goals as stars to guide you and celebrate each achievement as a beacon of your journeys brilliance."',
                          style: TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0),
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                              fontFamily: 'Courier'),
                        )),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            top: size.height * 0.9,
            left: size.width * 0.7,
            child: Animate(
              effects: [FlipEffect(curve: Curves.easeIn)],
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
                  'Start',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

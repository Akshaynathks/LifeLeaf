// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class Selection extends StatelessWidget {
  const Selection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
               Color.fromARGB(255, 95, 187, 83),
          Color.fromARGB(255, 233, 253, 118),
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 80, top: 60),
              child: Image(
                image: AssetImage('assets/logo lifeleaf.png'),
              ),
            ),
            const SizedBox(
              width: 100,
              height: 300,
            ),
            SizedBox(
              width: 300,
              height: 60,
              child: Animate(
                effects: [SlideEffect(duration: 1000.ms),const FadeEffect(),const FlipEffect(curve: Curves.easeIn)],
                child: ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, "signin"),
                  style: ElevatedButton.styleFrom(
                    elevation: 0.0,
                      backgroundColor:Colors.transparent,
                      side: const BorderSide(
                          color: Color.fromARGB(255, 10, 10, 10), width: 1.0),
                      shadowColor:
                          const Color.fromARGB(255, 15, 14, 14).withOpacity(0.20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)
                      )),
                  child: const Text(
                    'Sign In',
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                        color: Color.fromARGB(255, 16, 16, 16)),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 300,
              height: 60,
              child: Animate(
                effects: [SlideEffect(duration: 1000.ms),const FadeEffect(),const FlipEffect(curve: Curves.easeIn)],
                child: ElevatedButton(
                  onPressed: () => Navigator.pushNamed(context, 'signup'),
                  style: ElevatedButton.styleFrom(
                    elevation: 1.0,
                    backgroundColor:Colors.transparent,
                    side: const BorderSide(
                        color: Color.fromARGB(255, 11, 11, 11), width: 1.0),
                    shadowColor:
                        const Color.fromARGB(255, 15, 14, 14).withOpacity(0.20),
                        shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)
                      )
                  ),
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 20,
                        color:Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

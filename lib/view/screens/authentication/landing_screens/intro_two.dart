import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IntroTwo extends StatelessWidget {
  const IntroTwo({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
              Color.fromARGB(255, 248, 141, 88),
              Color.fromARGB(255, 137, 240, 139)
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
            child: Column(
              children: [
                SizedBox(
                  height: 60,
                ),
                SizedBox(
                  height: 70,
                ),
                Container(
                    width: size.width * 0.9,
                    child: Image(
                        image: AssetImage(
                            'assets/output-onlinepngtools (2).png'))),
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width: 300,
                        child: Text(
                          '"Capture the moments, cherish the memories, and let them inspire your journey forward."',
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
            top: size.height * 0.917,
            left: size.width * 0.1,
            child: SizedBox(
              width: size.width * 0.8,
              child: Row(
                children: [
                  Spacer(),
                  Text(
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

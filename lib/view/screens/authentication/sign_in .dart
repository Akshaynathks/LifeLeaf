// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:life_leaf/controller/user_db_function/authentication_db_function.dart';
import 'package:life_leaf/view/screens/authentication/function/authentication_function.dart';
import 'package:life_leaf/view/screens/home_screen/home_screen.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController loginUsernameController = TextEditingController();
  final TextEditingController loginPasswordController = TextEditingController();
  bool isObscure = true;
  @override
  void initState() {
    super.initState();
    // userBox = Hive.box<User>('user_details');
    UserDb.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 139, 240, 137),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [
          Color.fromARGB(255, 139, 240, 137),
          Color.fromARGB(255, 224, 248, 88),
        ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        child: ListView(children: [
          Column(
            children: [
              const SizedBox(
                height: 60,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 70,
                  ),
                  Column(
                    children: [
                      Animate(
                        effects: [
                          FadeEffect(duration: 800.ms),
                          const SlideEffect(curve: Curves.easeIn)
                        ],
                        child: const Text(
                          "Welcome Back",
                          style: TextStyle(
                              fontSize: 30,
                              fontFamily: 'Times',
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      Animate(
                        effects: [
                          FadeEffect(duration: 800.ms),
                          const SlideEffect(curve: Curves.easeIn)
                        ],
                        child: const Text(
                          "Login To Your Account",
                          style: TextStyle(
                              fontFamily: 'Courier',
                              color: Color.fromARGB(255, 50, 49, 49)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Form(
                key: _formkey, // Add this line
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    children: [
                      Animate(
                        effects: [
                          FadeEffect(duration: 800.ms),
                          const SlideEffect(curve: Curves.easeIn)
                        ],
                        child: TextFormField(
                          controller: loginUsernameController,
                          cursorColor: Colors.white,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: "UserName",
                            labelStyle: TextStyle(color: Colors.black),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white)),
                            errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            prefixIcon: Icon(Icons.email),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your username';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Animate(
                        effects: [
                          FadeEffect(duration: 800.ms),
                          const SlideEffect(curve: Curves.easeIn)
                        ],
                        child: TextFormField(
                          controller: loginPasswordController,
                          cursorColor: Colors.white,
                          obscureText: isObscure ? true : false,
                          keyboardType: TextInputType.visiblePassword,
                          decoration: InputDecoration(
                            labelText: "Password",
                            labelStyle: const TextStyle(color: Colors.black),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            errorBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            focusedErrorBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  isObscure = !isObscure;
                                });
                              },
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter password';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Row(
                        children: [
                          SizedBox(
                            width: 155,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 300,
                        height: 60,
                        child: Animate(
                          effects: [
                            FadeEffect(duration: 800.ms),
                            const SlideEffect(curve: Curves.easeIn),
                            const FlipEffect(curve: Curves.easeIn)
                          ],
                          child: ElevatedButton(
                            onPressed: () async {
                              String enteredUsername =
                                  loginUsernameController.text.trim();
                              String enteredPassword =
                                  loginPasswordController.text.trim();
                              final isLogInValidate =
                                  _formkey.currentState!.validate();
                              if (isLogInValidate) {
                                bool isLoggedIn = await checkUserExist(
                                    enteredUsername, enteredPassword);
                                if (isLoggedIn) {
                                  // ignore: use_build_context_synchronously
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(
                                    builder: (context) {
                                      return const Home();
                                    },
                                  ));
                                } else {
                                  // ignore: use_build_context_synchronously
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      backgroundColor: Colors.red,
                                      content: Text(
                                        'Invalid username and password',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  );
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                elevation: 0.0,
                                backgroundColor: Colors.transparent,
                                side: const BorderSide(color: Colors.black),
                                shadowColor:
                                    const Color.fromARGB(255, 117, 199, 134)
                                        .withOpacity(0.20),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15))),
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 20,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Animate(
                            effects: [
                              FadeEffect(duration: 800.ms),
                              const SlideEffect(curve: Curves.easeIn)
                            ],
                            child: const Text(
                              'Dont Have An Account ?',
                              style: TextStyle(
                                  fontFamily: 'Courier',
                                  color: Color.fromARGB(255, 50, 49, 49)),
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(left: 20)),
                          TextButton(
                              onPressed: () {
                                Navigator.pushNamed(context, 'signup');
                              },
                              child: Animate(
                                effects: [
                                  FadeEffect(duration: 800.ms),
                                  const SlideEffect(curve: Curves.easeIn)
                                ],
                                child: const Text(
                                  'Sign Up',
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                ),
                              )),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ]),
      ),
    );
  }
}

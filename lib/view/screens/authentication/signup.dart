import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:life_leaf/controller/user_db_function/authentication_db_function.dart';
import 'package:life_leaf/model/user_model/user_model.dart';
import 'package:life_leaf/view/screens/authentication/signin%20.dart';
// import 'package:life_leaf/view/screens/authentication/function/authentication_function.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController _userName = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmpass = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isObscure = true;
  bool isObscure2 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 224, 248, 88),
      appBar: AppBar(
        leading: BackButton(
          onPressed: () => Navigator.pushNamed(context, 'welcome'),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
          Color.fromARGB(255, 224, 248, 88),
          Color.fromARGB(255, 139, 240, 137)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 80,
                    ),
                    Column(
                      children: [
                        Animate(
                           effects: [FadeEffect(duration: 800.ms),const SlideEffect(curve:Curves.easeIn)],
                          child: const Text(
                            "Register",
                            style: TextStyle(
                              fontSize: 40,
                              fontFamily: 'Times',
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                        ),
                        Animate(
                          effects: [FadeEffect(duration: 800.ms),const SlideEffect(curve:Curves.easeIn)],
                          child: const Text(
                            "Create Your New Account",
                            style: TextStyle(
                              fontFamily: 'Courier',
                              color: Color.fromARGB(255, 50, 49, 49),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                  ],
                ),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(  
                      children: [
                        Animate(
                          effects: [FadeEffect(duration: 800.ms),const SlideEffect(curve:Curves.easeIn)],
                          child: TextFormField(
                            controller: _userName,
                            cursorColor: Colors.white,
                            keyboardType: TextInputType.name,
                            decoration: const InputDecoration(
                              labelText: "UserName",
                              labelStyle: TextStyle(color: Colors.black),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                              ),
                              prefixIcon: Icon(Icons.person),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your username';
                              }
                              return null;
                            },
                            style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Animate(
                          effects: [FadeEffect(duration: 800.ms),const SlideEffect(curve:Curves.easeIn)],
                          child: TextFormField(
                            controller: _email,
                            cursorColor: Colors.white,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              labelText: "Email",
                              labelStyle: TextStyle(color: Colors.black),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
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
                                return 'Please enter your email';
                              }
                              if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                                return 'Enter a valid email address';
                              }
                              return null;
                            },
                            style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Animate(
                          effects: [FadeEffect(duration: 800.ms),const SlideEffect(curve:Curves.easeIn)],
                          child: TextFormField(
                            controller: _password,
                            obscureText: isObscure ? true : false,
                            cursorColor: Colors.white,
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
                                return 'Please enter your password';
                              }
                              if (value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              return null;
                            },
                            style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Animate(
                          effects: [FadeEffect(duration: 800.ms),const SlideEffect(curve:Curves.easeIn)],
                          child: TextFormField(
                            controller: _confirmpass,
                            obscureText: isObscure2 ? true : false,
                            cursorColor: Colors.white,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                              labelText: "Confirm Password",
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
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.visibility),
                                onPressed: () {
                                  setState(() {
                                    isObscure2 = !isObscure2;
                                  });
                                },
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please confirm your password';
                              }
                              if (value != _password.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                            style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: 350,
                          height: 60,
                          child: Animate(
                            effects: [FadeEffect(duration: 800.ms),const SlideEffect(curve:Curves.easeIn)],
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  userAlreadyExist();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 0.0,
                                backgroundColor: Colors.transparent,
                                side: const BorderSide(color:Colors.black),
                                shadowColor: const Color.fromARGB(255, 117, 199, 134)
                                    .withOpacity(0.20),
                                                        shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(15)
                                                )
                              ),
                              child: const Text(
                                'Sign Up',
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 20,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Animate(
                                 effects: [FadeEffect(duration: 800.ms),const SlideEffect(curve:Curves.easeIn)],
                                child: Container(
                                  height: 1, // Adjust line height as needed
                                  color: const Color.fromARGB(255, 0, 0, 0), // Set line color
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10.0,
                              ),
                              child: Animate(
                                effects: [FadeEffect(duration: 800.ms),const SlideEffect(curve:Curves.easeIn)],
                                child: const Text(
                                  'Already Have An Account',
                                  style: TextStyle(
                                     fontFamily: 'Courier',
                                    color:  Color.fromARGB(255, 50, 49, 49),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Animate(
                                 effects: [FadeEffect(duration: 800.ms),const SlideEffect(curve:Curves.easeIn)],
                                child: Container(
                                  height: 1, // Adjust line height as needed
                                  color: const Color.fromARGB(255, 3, 3, 3), // Set line color
                                ),
                              ),
                            ),
                          ],
                        ),
                        Animate(
                          effects: [FadeEffect(duration: 800.ms),const SlideEffect(curve:Curves.easeIn)],
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, 'signin');
                            },
                            child: const Text(
                              'Sign In',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void userAlreadyExist() async {
    final String enteredUsername = _userName.text.trim();
    final String enteredEmail = _email.text.trim();
    final String enteredPassword = _password.text.trim();

    final userExists = userNotifier.value.any(
      (user) => user.username == enteredUsername || user.email == enteredEmail,
    );
    if (userExists) {
      // Handle case where user already exists
      // showDialogueforUser(context: context);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('User Already Exists'),
            content: const Text(
                'The provided username or email is already registered.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      var newUser = User(
        username: enteredUsername,
        email: enteredEmail,
        password: enteredPassword,
      );
      await UserDb.addUser(newUser);
      await UserDb.getUser();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text(
            'Successfully completed',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Signin(),
        ),
      );
      _userName.clear();
      _email.clear();
      _password.clear();
      _confirmpass.clear();
    }
  }
}

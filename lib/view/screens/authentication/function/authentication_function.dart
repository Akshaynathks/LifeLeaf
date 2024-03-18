
import 'package:flutter/material.dart';
import 'package:life_leaf/controller/user_db_function/authentication_db_function.dart';
import 'package:shared_preferences/shared_preferences.dart';

  String? userid;

String? validateUsername(String? value) {
  if (value!.isEmpty) {
    return 'Please enter your username';
  } else {
    return null;
  }
}

String? validateEmail(String? email) {
  if (email == null || email.isEmpty) {
    return 'Enter an email address';
  }

  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  if (!emailRegex.hasMatch(email) || !email.contains('.') || !email.endsWith('.com')) {
    return 'Enter a valid email address';
  }
  return null; // Return null if the email is valid
}

String? validatePassword(String? value) {
  if (value!.isEmpty) {
    return 'Please enter a password';
  } else if (value.length < 5) {
    return 'Password must be at least 5 character';
  } else {
    return null;
  }
}

void userAlreadyExist() async {
  final sharedpref = await SharedPreferences.getInstance();
  sharedpref.setBool('userEntered', true);
}

bool validateEmailaddress(String email) {
  final RegExp regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  return regex.hasMatch(email);
}

//log in password
String? validateLoginPassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your Password';
  } else {
    return null;
  }
}

  Future<bool> checkUserExist(
     
      String enteredUsername, String enteredPassword) async {
    bool existingUser = userNotifier.value.any((user) {
       userid = user.key;
      return user.username == enteredUsername && user.password == enteredPassword;
    },);
    if (existingUser) {
      SharedPreferences sharedPref = await SharedPreferences.getInstance();
      sharedPref.setBool('userEntered', true);
      SharedPreferences sharedpreference = await SharedPreferences.getInstance();
      sharedpreference.setString('userEnteredId', userid!);
    }
    return existingUser;
  }

 Future <void> showDialogueforUser({BuildContext? context}){
  return  showDialog(
        context: context!,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('User Already Exists'),
            content: const Text(
                'The provided username or email already exists. Please use different credentials.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
  }
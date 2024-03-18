import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:life_leaf/model/goals_model/goals_main_model.dart';
import 'package:life_leaf/model/goals_model/goals_model.dart';
import 'package:life_leaf/model/journal_model/journal_model.dart';
import 'package:life_leaf/model/memories_model/memories_model.dart';
import 'package:life_leaf/model/user_model/user_model.dart';
import 'package:life_leaf/view/screens/Memorie%20_screen/memories_add.dart';
import 'package:life_leaf/view/screens/authentication/landing_screens/intro_one.dart';
import 'package:life_leaf/view/screens/authentication/landing_screens/intro_three.dart';
import 'package:life_leaf/view/screens/authentication/landing_screens/intro_two.dart';
import 'package:life_leaf/view/screens/goals_screen/goal_add.dart';
import 'package:life_leaf/view/screens/goals_screen/goals.dart';
import 'package:life_leaf/view/screens/home_screen/Home.dart';
import 'package:life_leaf/view/screens/authentication/Welcome.dart';
import 'package:life_leaf/view/screens/authentication/signin%20.dart';
import 'package:life_leaf/view/screens/authentication/signup.dart';
import 'package:life_leaf/view/screens/authentication/splash.dart';
import 'package:life_leaf/view/screens/journal_screen/journal.dart';
import 'package:life_leaf/view/screens/journal_screen/journal_add.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(JournalModelAdapter());
  Hive.registerAdapter(GoalsMainModelAdapter());
  Hive.registerAdapter(GoalsModelAdapter());
  Hive.registerAdapter(MemoriesModelAdapter());

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
      routes: {
        "welcome": (context) => selection(),
        "signin": (context) => Signin(),
        "signup": (context) => Signup(),
        "home": (context) => Home(),
        "addGoal": (context) => AddGoal(),
        "goal": (context) => Goals(),
        "addJournal": (context) => journalAdd(),
        "journal": (context) => Journal(),
        "addMemories": (context) => MemoriesAdd(),
        "introOne": (context) => IntroOne(),
        "introTwo": (context) => IntroTwo(),
        "introThree": (context) => IntroThree(),
        // "openJournal":(context) => JournalOpen(title: '',),
      },
    );
  }
}

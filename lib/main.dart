import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:life_leaf/model/goals_model/goals_main_model.dart';
import 'package:life_leaf/model/goals_model/goals_model.dart';
import 'package:life_leaf/model/habit_model/habit_model.dart';
import 'package:life_leaf/model/journal_model/journal_model.dart';
import 'package:life_leaf/model/memories_model/memories_model.dart';
import 'package:life_leaf/model/reminder_model/reminder_model.dart';
import 'package:life_leaf/model/user_model/user_model.dart';
import 'package:life_leaf/view/screens/Memorie%20_screen/memories_add.dart';
import 'package:life_leaf/view/screens/authentication/landing_screens/intro_one.dart';
import 'package:life_leaf/view/screens/authentication/landing_screens/intro_three.dart';
import 'package:life_leaf/view/screens/authentication/landing_screens/intro_two.dart';
import 'package:life_leaf/view/screens/goals_screen/goal_add.dart';
import 'package:life_leaf/view/screens/goals_screen/goals.dart';
import 'package:life_leaf/view/screens/home_screen/home_screen.dart';
import 'package:life_leaf/view/screens/authentication/welcome.dart';
import 'package:life_leaf/view/screens/authentication/sign_in%20.dart';
import 'package:life_leaf/view/screens/authentication/signup.dart';
import 'package:life_leaf/view/screens/authentication/splash.dart';
import 'package:life_leaf/view/screens/journal_screen/journal.dart';
import 'package:life_leaf/view/screens/journal_screen/journal_add.dart';
import 'package:life_leaf/view/screens/reminder_screen/reminder_add.dart';
import 'package:life_leaf/view/screens/sidebar_menu_Screen/about.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  AwesomeNotifications().initialize(null, [
    NotificationChannel(
        channelKey: 'instant_notification',
        channelName: 'basic instant notification',
        channelDescription:
            'notification channel triggers notification instantly',
        channelGroupKey: 'reminders',
        defaultColor: Colors.amber,
        ledColor: Colors.blue)
  ]);

  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(JournalModelAdapter());
  Hive.registerAdapter(GoalsMainModelAdapter());
  Hive.registerAdapter(GoalsModelAdapter());
  Hive.registerAdapter(MemoriesModelAdapter());
  Hive.registerAdapter(ReminderModelAdapter());
  Hive.registerAdapter(HabitModelAdapter());

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

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
        "welcome": (context) => const Selection(),
        "signin": (context) => const Signin(),
        "signup": (context) => const Signup(),
        "home": (context) => const Home(),
        "addGoal": (context) => const AddGoal(),
        "goal": (context) => const Goals(),
        "addJournal": (context) => const JournalAdd(),
        "journal": (context) => const Journal(),
        "addMemories": (context) => const MemoriesAdd(),
        "introOne": (context) => const IntroOne(),
        "introTwo": (context) => const IntroTwo(),
        "introThree": (context) => const IntroThree(),
        "About": (context) => const AboutScreen(),
        "addreminder": (context) => const AddReminder(),
      },
    );
  }
}

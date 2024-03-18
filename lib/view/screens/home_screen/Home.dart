
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:life_leaf/controller/user_db_function/authentication_db_function.dart';
import 'package:life_leaf/view/screens/Memorie%20_screen/memories.dart';
import 'package:life_leaf/view/screens/authentication/signin%20.dart';
import 'package:life_leaf/view/screens/goals_screen/goals.dart';
import 'package:life_leaf/view/screens/habit_screen/habit.dart';
import 'package:life_leaf/view/screens/journal_screen/journal.dart';
import 'package:life_leaf/view/screens/reminder_screen/reminder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  bool isChanged = false;
  late AnimationController controller;
  late String greeting = '';
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _updateGreeting(); // Update the greeting text initially
    UserDb.getUser();
  }

  void _updateGreeting() {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      setState(() {
        greeting = 'Good Morning';
      });
    } else if (hour < 17) {
      setState(() {
        greeting = 'Good Afternoon';
      });
    } else {
      setState(() {
        greeting = 'Good Evening';
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 38, 36, 36),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 113, 191, 117),
          automaticallyImplyLeading: false,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Animate(
                 effects: [FadeEffect(duration: 1500.ms),const SlideEffect(curve:Curves.easeIn)],
                child: Text(greeting,
                    style: const TextStyle(
                        fontFamily: 'Courier',
                        color: Color.fromARGB(255, 242, 249, 245),
                        fontWeight: FontWeight.w700)),
              ),
              ValueListenableBuilder(
                valueListenable: userNotifier,
                builder: (context, value, child) {
                  return Animate(
                     effects: [FadeEffect(duration: 1500.ms),const SlideEffect(curve:Curves.easeIn)],
                    child: Text(value[0].username,
                        style: const TextStyle(
                            fontFamily: 'Courier',
                            color: Color.fromARGB(255, 234, 245, 239),
                            fontWeight: FontWeight.w700)),
                  );
                },
              ),
            ],
          ),
          bottom: const TabBar(
              tabAlignment: TabAlignment.start,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorWeight: 0.5,
              indicatorPadding: EdgeInsets.zero,
              labelColor: Colors.black,
              isScrollable: true,
              labelStyle:
                  TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              unselectedLabelColor: Colors.white,
              // indicator: BoxDecoration(
              //   color: Color.fromARGB(255, 224, 249, 224),
              //   borderRadius: BorderRadius.circular(40),
              // ),
              dividerColor: Color.fromARGB(255, 113, 191, 117),
              tabs: [
                Tab(
                  text: 'Goals',
                ),
                Tab(
                  text: "Journals",
                ),
                Tab(
                  text: 'Memories',
                ),
                Tab(
                  text: 'Reminder',
                ),
                Tab(
                  text: 'Habits',
                ),
              ]),
        ),
        body: const TabBarView(children: [
          Goals(),
          Journal(),
          Memories(),
          Reminder(),
          Habit(),
        ]),
        endDrawer: Drawer(
          backgroundColor: const Color.fromARGB(255, 38, 36, 36),
          child: ListView(
            padding: const EdgeInsets.all(0),
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 113, 191, 117),
                ), //BoxDecoration
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          alignment: Alignment.topLeft,
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                    ValueListenableBuilder(
                      valueListenable: userNotifier,
                      builder: (context, value, child) => Column(
                        children: [
                          Text(
                            value[0].username,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 25),
                          ),
                          Text(
                            value[0].email,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              DrawerItem(
                title: 'My Profile',
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              DrawerItem(
                title: 'Goals',
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              DrawerItem(
                title: 'Journals',
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              DrawerItem(
                title: 'Memories',
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              DrawerItem(
                title: 'Reminders',
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              DrawerItem(
                title: 'Habits',
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              const SizedBox(
                height: 100,
              ),
              const Divider(
                thickness: 2,
                color: Colors.white,
                endIndent: 30,
                indent: 30,
              ),
              const SizedBox(
                height: 10,
              ),
              DrawerItem(
                title: 'Settings',
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                  leading: const Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                  title: const Text(
                    'LogOut',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () async {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Log out'),
                            content:
                                const Text('Are you sure you want to log out?'),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Cancel")),
                              TextButton(
                                  onPressed: () async {
                                    Navigator.pop(context);
                                    final sharedpref =
                                        await SharedPreferences.getInstance();
                                    await sharedpref.remove('userEntered');
                                    final shredpre =
                                        await SharedPreferences.getInstance();
                                    await shredpre.remove('userEnteredId');
                                    // ignore: use_build_context_synchronously
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const Signin(),
                                        ),
                                        (route) => false);
                                  },
                                  child: const Text("Log out")),
                            ],
                          );
                        });
                  })
            ],
          ),
        ),
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const DrawerItem({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: Card(
        color: const Color.fromARGB(255, 128, 127, 127),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: ListTile(
          title: Center(
              child: Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              title,
              style: const TextStyle(
                  color: Color.fromARGB(255, 223, 223, 223),
                  fontSize: 18,
                  fontWeight: FontWeight.w400),
            ),
          )),
          onTap: onTap,
        ),
      ),
    );
  }
}

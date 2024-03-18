import 'package:flutter/material.dart';

class Habit extends StatefulWidget {
  const Habit({super.key});

  @override
  State<Habit> createState() => _HabitState();
}

class _HabitState extends State<Habit> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 62, 62, 62),
      body: Column(children: [
      //  CustomSearchBar(onSearch: (query) {
      //           // Handle search query
      //         }),
         Column(
           children: [
            SizedBox(height: 200,),
             Text('No Habits',style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Times',
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 113, 191, 117)),),
                                SizedBox(
          width: 200,
          child: Text('Create a Habit and it will show up hear',
                          style: TextStyle(
                              fontFamily: 'Courier',
                              color: Color.fromARGB(255, 195, 191, 191)),),
        )
           ],
         ),
      ]),
    );
  }
}
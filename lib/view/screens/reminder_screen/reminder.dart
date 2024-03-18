import 'package:flutter/material.dart';

class Reminder extends StatefulWidget {
  const Reminder({super.key});

  @override
  State<Reminder> createState() => _ReminderState();
}

class _ReminderState extends State<Reminder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 62, 62, 62),
      body: Column(
        children: [
          // CustomSearchBar(onSearch: (query) {
          //       // Handle search query
          //     }),
          Column(
            children: [
              SizedBox(
                height: 200,
              ),
              Text(
                'No Reminders',
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Times',
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 113, 191, 117)),
              ),
              SizedBox(
                width: 200,
                child: Text(
                  'Create a reminder and it will show up hear',
                  style: TextStyle(
                      fontFamily: 'Courier',
                      color: Color.fromARGB(255, 195, 191, 191)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

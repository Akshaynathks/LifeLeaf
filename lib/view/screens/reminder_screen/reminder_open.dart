import 'package:flutter/material.dart';
import 'package:life_leaf/controller/reminder_db_functions/reminder_db_functions.dart';
import 'package:life_leaf/view/widgets/scaffold_messenger.dart';

class ReminderOpen extends StatefulWidget {
  final String title;
  final String descr;
  final String date;
  final String rkey;
  const ReminderOpen(
      {super.key,
      required this.title,
      required this.descr,
      required this.date,
      required this.rkey});

  @override
  State<ReminderOpen> createState() => _ReminderOpenState();
}

class _ReminderOpenState extends State<ReminderOpen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 38, 36, 36),
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: Text(
          widget.title,
          style: const TextStyle(
              color: Color.fromARGB(255, 145, 233, 151),
              fontFamily: 'Times',
              fontSize: 20,
              fontWeight: FontWeight.w500),
        ),
        actions: [
          PopupMenuButton(
            iconColor: Colors.white,
            iconSize: 30,
            itemBuilder: (context) => [
              PopupMenuItem(
                child: const ListTile(
                  leading: Icon(Icons.delete),
                  title: Text('Delete'),
                ),
                onTap: () async {
                  bool confirmed = await showDeleteConfirmation(context);
                  if (confirmed) {
                    ReminderDb.deleteReminder(widget.rkey);
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          )
        ],
      ),
      body: Column(children: [
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            const SizedBox(
              width: 20,
            ),
            Text(
              widget.date,
              style: const TextStyle(
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontSize: 15,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),

        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(
                widget.descr,
                style: const TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        )
      ]),
    );
  }
}

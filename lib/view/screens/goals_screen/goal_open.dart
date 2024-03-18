import 'package:flutter/material.dart';
import 'package:life_leaf/controller/goals_db_functions/goals_db_functions.dart';
import 'package:life_leaf/model/goals_model/goals_model.dart';

class GoalOpen extends StatefulWidget {
  final String title;
  final List<GoalsModel> stepss;
  final String mainGoalkey;
  const GoalOpen(
      {super.key,
      required this.title,
      required this.stepss,
      required this.mainGoalkey});

  @override
  State<GoalOpen> createState() => _GoalOpenState();
}

class _GoalOpenState extends State<GoalOpen> {
  bool? isTicked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 62, 62, 62),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: BackButton(
          color: Colors.white,
          onPressed: () {
            Navigator.pushNamed(context, 'home');
          },
        ),
        title: Text(
          widget.title,
          style: TextStyle(
              color: Color.fromARGB(255, 169, 249, 172), fontSize: 20),
        ),
        actions: [
          PopupMenuButton(
            iconColor: Colors.white,
            iconSize: 30,
            itemBuilder: (context) => [
              PopupMenuItem(
                child: ListTile(
                  leading: Icon(Icons.edit),
                  title: Text('Edit'),
                ),
                onTap: () {},
              ),
              PopupMenuItem(
                child: ListTile(
                  leading: Icon(Icons.delete),
                  title: Text('Delete'),
                ),
                onTap: () {
                  GoalDb.deleteGoal(widget.mainGoalkey);
                  Navigator.pop(context);
                },
              ),
            ],
          )
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView.builder(
            itemCount: widget.stepss.length,
            itemBuilder: (context, index) {
              return Card(
                  child: ListTile(
                title: Text(widget.stepss[index].title),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.stepss[index].description),
                    Text(widget.stepss[index].targetDate ?? '')
                  ],
                ),
                onLongPress: () {
                  //Delete option
                },
                trailing: Checkbox(
                  value: isTicked,
                  activeColor: Colors.green,
                  onChanged: (newBool) {
                    setState(() {
                      isTicked = !isTicked!;
                    });
                  },
                ),
              ));
            },
          )),
    );
  }
}

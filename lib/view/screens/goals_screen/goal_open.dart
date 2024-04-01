import 'package:flutter/material.dart';
import 'package:life_leaf/controller/goals_db_functions/goals_db_functions.dart';
import 'package:life_leaf/model/goals_model/goals_main_model.dart';
import 'package:life_leaf/model/goals_model/goals_model.dart';
import 'package:life_leaf/view/screens/goals_screen/goals_edit.dart';
import 'package:life_leaf/view/widgets/scaffold_messenger.dart';

class GoalOpen extends StatefulWidget {
  final String title;
  final List<GoalsModel> stepss;
  final GoalsMainModel goal;
  final String mainGoalkey;
  final String stepkey;
  final int isMarked;
  const GoalOpen(
      {super.key,
      required this.title,
      required this.stepss,
      required this.mainGoalkey,
      required this.goal,
      required this.stepkey,
      required this.isMarked});

  @override
  State<GoalOpen> createState() => _GoalOpenState();
}

class _GoalOpenState extends State<GoalOpen> {
  bool? isTicked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 49, 49, 49),
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
          style: const TextStyle(
              color: Color.fromARGB(255, 227, 251, 92),
              fontSize: 25,
              fontWeight: FontWeight.w800),
        ),
        actions: [
          PopupMenuButton(
            iconColor: Colors.white,
            iconSize: 30,
            itemBuilder: (context) => [
              PopupMenuItem(
                child: const ListTile(
                  leading: Icon(Icons.edit),
                  title: Text('Edit'),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditGoal(
                          stepss: widget.stepss,
                          title: widget.title,
                          mainGoalkey: widget.mainGoalkey,
                          goal: widget.goal,
                          stepkey: widget.stepkey,
                          isMarked: widget.isMarked,
                        ),
                      ));
                },
              ),
              PopupMenuItem(
                child: const ListTile(
                  leading: Icon(Icons.delete),
                  title: Text('Delete'),
                ),
                onTap: () async {
                  bool confirmed = await showDeleteConfirmation(context);
                  if (confirmed) {
                    GoalDb.deleteGoal(widget.mainGoalkey);                                          // Perform delete operation
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                  }
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
                  color: const Color.fromARGB(255, 238, 208, 155),
                  child: ListTile(
                    title: Text(
                      widget.stepss[index].title,
                      style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 20,
                          color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.stepss[index].description,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18),
                        ),
                        Text(widget.stepss[index].targetDate ?? '')
                      ],
                    ),
                    onLongPress: () {
                      //Delete option
                    },
                  ));
            },
          )),
    );
  }
}

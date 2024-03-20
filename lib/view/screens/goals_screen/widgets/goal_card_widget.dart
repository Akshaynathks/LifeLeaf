import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:life_leaf/model/goals_model/goals_main_model.dart';
import 'package:life_leaf/model/goals_model/goals_model.dart';
import 'package:life_leaf/view/screens/goals_screen/goal_open.dart';
import 'package:life_leaf/view/screens/journal_screen/journal.dart';

class GoalsCardWidget extends StatefulWidget {
  final String title;
  final List<GoalsModel> stepss;
  final GoalsMainModel goal;
  final String stepkey;
  // final String date;
  final String mainKey;
  const GoalsCardWidget({
    super.key,
    required this.title,
    required this.stepss,
    // required this.date,
    required this.mainKey,
    required this.goal,
    required this.stepkey,
  });

  @override
  State<GoalsCardWidget> createState() => _GoalsCardWidgetState();
}

class _GoalsCardWidgetState extends State<GoalsCardWidget> {
  bool isMarked = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content:
                Text(!isMarked ? 'Mark as Completed' : 'Mark as InCompleted'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel')),
              TextButton(
                  onPressed: () {
                    setState(() {
                      isMarked = !isMarked;
                    });
                    Navigator.pop(context);
                  },
                  child: Text('Ok')),
            ],
          ),
        );
      },
      onTap: () {
        Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (context) => GoalOpen(
                      title: widget.title,
                      stepss: widget.stepss,
                      mainGoalkey: widget.mainKey,
                      goal: widget.goal,
                      stepkey: widget.stepkey,
                    )));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Animate(
          effects: [
            FadeEffect(duration: 700.ms),
            const SlideEffect(curve: Curves.easeIn)
          ],
          child: Card(
            child: Container(
              height: 80,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: !isMarked
                      ? Color.fromARGB(255, 244, 178, 66)
                      : Colors.green,
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        widget.title,
                        style: TextStyle(
                            color: Color.fromARGB(255, 9, 9, 9),
                            fontWeight: FontWeight.bold,
                            fontSize: 22),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                          child: Text(
                            'Not completed',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text('_ out of _ Tasks Compleated',
                              style: TextStyle(fontWeight: FontWeight.w500)),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

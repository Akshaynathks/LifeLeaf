import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:life_leaf/controller/goals_db_functions/goals_db_functions.dart';
import 'package:life_leaf/model/goals_model/goals_main_model.dart';
import 'package:life_leaf/model/goals_model/goals_model.dart';
import 'package:life_leaf/view/screens/goals_screen/goal_open.dart';

class GoalsCardWidget extends StatefulWidget {
  final String title;
  final List<GoalsModel> stepss;
  final GoalsMainModel goal;
  final String stepkey;
  // final String date;
  final String mainKey;
  final int isMarked;
  const GoalsCardWidget({
    super.key,
    required this.title,
    required this.stepss,
    // required this.date,
    required this.mainKey,
    required this.goal,
    required this.stepkey,
    required this.isMarked,
  });

  @override
  State<GoalsCardWidget> createState() => _GoalsCardWidgetState();
}

class _GoalsCardWidgetState extends State<GoalsCardWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {},
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
                      isMarked: widget.isMarked,
                    )));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Animate(
          effects: [
            FadeEffect(duration: 800.ms),
          ],
          child: Card(
            child: Container(
              height: 80,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: widget.isMarked == 1
                      ? Colors.green
                      : const Color.fromARGB(255, 244, 178, 66),
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: SizedBox(
                        width: 150,
                        child: Column(
                          children: [
                            Text(
                              overflow: TextOverflow.ellipsis,
                              widget.title,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            ),
                            Text(
                              widget.isMarked == 0
                                  ? 'Not completed'
                                  : 'Completed',
                              style: const TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: VerticalDivider(
                        thickness: 2,
                        color: Color.fromARGB(255, 255, 255, 255),
                        width: 30,
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      child: InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              content: Text(widget.isMarked == 1
                                  ? 'Mark as InCompleted'
                                  : 'Mark as Completed'),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Cancel')),
                                TextButton(
                                    onPressed: () {
                                      final newGoal = GoalsMainModel(
                                        goalTitle: widget.title,
                                        goalList: widget.stepss,
                                        key: widget.mainKey,
                                        isMarked: widget.isMarked == 0 ? 1 : 0,
                                      );
                                      GoalDb.updateGoal(newGoal);
                                      GoalDb.getGoals();
                                      Navigator.pop(context);
                                    },
                                    child: const Text('Ok')),
                              ],
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            Animate(
                              effects: [
                                TintEffect(delay: 1000.ms),
                                const ShakeEffect(
                                    duration: Durations.extralong4),
                                const FadeEffect()
                              ],
                              child: IconButton(
                                color: const Color.fromARGB(136, 0, 0, 0),
                                icon: const Icon(
                                  Icons.touch_app,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      content: Text(widget.isMarked == 1
                                          ? 'Mark as InCompleted'
                                          : 'Mark as Completed'),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Cancel')),
                                        TextButton(
                                            onPressed: () {
                                              final newGoal = GoalsMainModel(
                                                goalTitle: widget.title,
                                                goalList: widget.stepss,
                                                key: widget.mainKey,
                                                isMarked: widget.isMarked == 0
                                                    ? 1
                                                    : 0,
                                              );
                                              GoalDb.updateGoal(newGoal);
                                              GoalDb.getGoals();
                                              Navigator.pop(context);
                                            },
                                            child: const Text('Ok')),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                            const Text(
                              'Tap to change State',
                              style: TextStyle(
                                  fontSize: 9,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                      ),
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:life_leaf/model/goals_model/goals_model.dart';
import 'package:life_leaf/view/screens/goals_screen/goal_open.dart';

class GoalsCardWidget extends StatelessWidget {
  final String title;
  final List<GoalsModel> stepss;
  // final String date;
  final String mainKey;
  const GoalsCardWidget({
    super.key,
    required this.title,
    required this.stepss,
    // required this.date,
    required this.mainKey,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (context) => GoalOpen(
                      title: title,
                      stepss: stepss,
                      mainGoalkey: mainKey,
                    )));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Container(
            height: 80,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 244, 178, 66),
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      title,
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
    );
  }
}

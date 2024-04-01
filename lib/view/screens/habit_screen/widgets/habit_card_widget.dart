import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';
import 'package:life_leaf/controller/habit_db_functions/habit_db_functions.dart';
import 'package:life_leaf/model/habit_model/habit_model.dart';
import 'package:life_leaf/view/screens/habit_screen/habit_open.dart';
import 'package:life_leaf/view/widgets/scaffold_messenger.dart';

class HabitCardWidget extends StatefulWidget {
  final String title;
  final List<String> maxcompleate;
  final String maxskipped;
  final String hkey;
  // final String date;

  const HabitCardWidget({
    super.key,
    required this.title,
    required this.maxcompleate,
    required this.maxskipped,
    required this.hkey,
  });

  @override
  State<HabitCardWidget> createState() => _HabitCardWidgetState();
}

class _HabitCardWidgetState extends State<HabitCardWidget> {
  List<String> datess = [];

  @override
  void initState() {
    super.initState();
    datess.addAll(widget.maxcompleate);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => HabitOpen(
                  title: widget.title,
                  maxcompleate: widget.maxcompleate,
                  maxskipped: widget.maxskipped,
                  hkey: widget.hkey),
            ));
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
                  color: const Color.fromARGB(255, 244, 178, 66),
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: SizedBox(
                        width: 200,
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
                            const Text(
                              'max',
                              // widget.maxcompleate,
                              style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: SizedBox(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  elevation: 15,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  backgroundColor:
                                      const Color.fromARGB(0, 131, 129, 129)),
                              onPressed: () async {
                                bool confirmed =
                                    await showCompleateConfirmation(context);
                                if (confirmed) {
                                  String formatDate(DateTime dateTime) {
                                    return DateFormat('yyyy/MM/dd')
                                        .format(dateTime);
                                  }

                                  String formattedDate =
                                      formatDate(DateTime.now());
                                  datess.add(formattedDate);

                                  final newHabit = HabitModel(
                                      title: widget.title,
                                      maxCompleated: datess,
                                      maxSkipped: widget.maxskipped,
                                      hkey: widget.hkey);
                                  HabitDb.updateHabit(newHabit);
                                  HabitDb.getHabit();
                                }
                              },
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Done',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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

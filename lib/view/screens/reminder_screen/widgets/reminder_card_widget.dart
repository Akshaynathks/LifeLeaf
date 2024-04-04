import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:life_leaf/view/screens/reminder_screen/reminder_open.dart';

class ReminderCardWidget extends StatefulWidget {
  final String title;
  final String descr;
  final String date;
  final String rkey;
  final String time;
  // final String date;

  const ReminderCardWidget({
    super.key,
    required this.title,
    required this.date,
    required this.descr,
    required this.rkey,
    required this.time,
  });

  @override
  State<ReminderCardWidget> createState() => _GoalsCardWidgetState();
}

class _GoalsCardWidgetState extends State<ReminderCardWidget> {
  @override
  Widget build(BuildContext context) {
     final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => ReminderOpen(
                  title: widget.title,
                  descr: widget.descr,
                  date: widget.date,
                  rkey: widget.rkey),
            ));
      },
      child: Padding(
        padding: const EdgeInsets.all(3.0),
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
                  children: [
                    SizedBox(
                      width: size.width*0.50,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              widget.title,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 255, 255, 255),
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            ),
                          ),
                          Text(
                            widget.descr,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: VerticalDivider(
                        thickness: 1,
                        color: Color.fromARGB(255, 255, 255, 255),
                        width: 30,
                      ),
                    ),
                    
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(widget.date,
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Color.fromARGB(255, 72, 72, 72))),
                        Text(widget.time,
                            style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                color: Color.fromARGB(255, 72, 72, 72)))
                      ],
                    ),
                    SizedBox(
                      width:size.width*0.05 ,
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

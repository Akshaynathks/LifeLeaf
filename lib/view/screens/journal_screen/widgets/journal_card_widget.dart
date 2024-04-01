import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:life_leaf/view/screens/journal_screen/journal_open.dart';

class JournalCardWidget extends StatelessWidget {
  final String title;
  final String notes;
  final String date;
  final String jkey;
  final List<String?> images;
  const JournalCardWidget({
    super.key,
    required this.title,
    required this.notes,
    required this.date,
    required this.jkey,
    required this.images,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) => JournalOpen(
                title: title,
                note: notes,
                date: date,
                jkey: jkey,
                images: images,
              ),
            ));
      },
      child: Animate(
        effects: [
          FadeEffect(duration: 1000.ms),
        ],
        child: Padding(
          padding: const EdgeInsets.only(left: 5.0, top: 5.0,right: 5.0),
          child: Card(
            child: Container(
              height: 200,
              width: 160,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 238, 208, 155),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left:8.0),
                    child: Text(
                      title,
                      style: const TextStyle(
                          color: Color.fromARGB(255, 9, 9, 9),
                          fontWeight: FontWeight.w600,fontSize: 20),
                    ),
                  ),
                  Align(
                      alignment: Alignment.topLeft,
                      child: SizedBox(
                        height: 136,
                        child: Text(
                          notes,style: const TextStyle(fontFamily: 'Courier',fontWeight: FontWeight.bold),
                        ),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

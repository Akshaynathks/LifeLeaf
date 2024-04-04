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
    final size = MediaQuery.of(context).size;
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
          padding: const EdgeInsets.all(3.0),
          child: Card(
            child: Container(
              height: size.height * 0.10,
              width: 160,
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 244, 178, 66),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: size.width * 0.60,
                          child: Text(
                            title,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 9, 9, 9),
                                fontWeight: FontWeight.w600,
                                fontSize: 20),
                          ),
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Text(
                            date,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                      alignment: Alignment.topLeft,
                      child: SizedBox(
                        height: size.height * 0.05,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                          child: SizedBox(
                            width: size.width * 0.85,
                            child: Text(
                              notes,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontFamily: 'Courier',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17),
                            ),
                          ),
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

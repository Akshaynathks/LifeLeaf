import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    required this.date, required this.jkey, required this.images,
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
                jkey: jkey, images:images,
              ),
            ));
      },
      child: Card(
        child: Container(
          // color: Colors.white,
          height: 200,
          width: 160,
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 231, 230, 230),
              borderRadius: BorderRadius.circular(15)),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                title,
                style: TextStyle(
                    color: Color.fromARGB(255, 9, 9, 9),
                    fontWeight: FontWeight.bold),
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: SizedBox(
                    height: 130,
                    child: Text(
                      notes,
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

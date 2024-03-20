import 'dart:io';

import 'package:flutter/material.dart';
import 'package:life_leaf/controller/journal_db_functions/journals_db_functions.dart';
import 'package:life_leaf/controller/memories_db_functions/memories_db_functions.dart';
import 'package:life_leaf/model/journal_model/journal_model.dart';
import 'package:life_leaf/model/memories_model/memories_model.dart';

class OpenJournalImage extends StatefulWidget {
  final String mkey;
  final List<String?> imagesss;
  final String date;
  final String title;
  final String image;
  final String note;
  const OpenJournalImage(
      {super.key,
      required this.image,
      required this.imagesss,
      required this.date,
      required this.title,
      required this.mkey,
      required this.note});

  @override
  State<OpenJournalImage> createState() => _OpenJournalImageState();
}

class _OpenJournalImageState extends State<OpenJournalImage> {
  String dates = '';
  List<String?> imagess = [];
  String titlee = '';

  @override
  void initState() {
    // TODO: implement initState
    dates = widget.date;
    imagess = widget.imagesss;
    titlee = widget.title;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        actions: [
          IconButton(
              onPressed: () {
                imagess.remove(widget.image);
                final updatedJournal = JournalModel(
                    journalkey: widget.mkey,
                    journalTitle: titlee,
                    images: imagess,
                    journalDate: widget.date,
                    journalNotes: widget.note);
                JournalDb.updateJournal(updatedJournal);
                JournalDb.getjournals();
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.delete,
                color: Colors.white,
              ))
        ],
      ),
      backgroundColor: Color.fromARGB(255, 67, 67, 64),
      body: Center(
        child: Container(
          width: double.infinity,
          // height: 250,
          decoration: BoxDecoration(
              image: DecorationImage(image: FileImage(File(widget.image)))),
        ),
      ),
    );
  }
}

import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:life_leaf/controller/journal_db_functions/journals_db_functions.dart';
import 'package:life_leaf/view/screens/journal_screen/journal_edit.dart';
import 'package:life_leaf/view/screens/journal_screen/journal_single_open.dart';
import 'package:life_leaf/view/widgets/scaffold_messenger.dart';

class JournalOpen extends StatefulWidget {
  final String title;
  final String note;
  final String date;
  final String jkey;
  final List<String?> images;
  const JournalOpen({
    super.key,
    required this.title,
    required this.note,
    required this.date,
    required this.jkey,
    required this.images,
  });

  @override
  State<JournalOpen> createState() => _JournalOpenState();
}

class _JournalOpenState extends State<JournalOpen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 62, 62, 62),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: BackButton(
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
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
                      CupertinoPageRoute(
                        builder: (context) => JournalEdit(
                          date: widget.date,
                          title: widget.title,
                          note: widget.note,
                          jkey: widget.jkey,
                          images: widget.images,
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
                    JournalDb.deleteJournal(widget.jkey);
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.date,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w900),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              widget.note,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 300,
              child: ValueListenableBuilder(
                valueListenable: journalsNotifier,
                builder: (context, value, child) => GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10),
                  itemCount: widget.images.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => OpenJournalImage(
                                image: widget.images[index]!,
                                imagesss: widget.images,
                                title: widget.title,
                                mkey: widget.jkey,
                                date: widget.date,
                                note: widget.note,
                              ),
                            ));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(File(widget.images[index]!)))),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

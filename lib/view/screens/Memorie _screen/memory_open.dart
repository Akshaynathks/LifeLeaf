import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:life_leaf/controller/memories_db_functions/memories_db_functions.dart';
import 'package:life_leaf/view/screens/Memorie%20_screen/memories_edit.dart';
import 'package:life_leaf/view/screens/Memorie%20_screen/memories_single_open.dart';
import 'package:life_leaf/view/widgets/scaffold_messenger.dart';

class MemoriesOpen extends StatefulWidget {
  final String title;
  final List<String?> images;
  final String mkey;
  final String mainImage;
  const MemoriesOpen(
      {super.key,
      required this.title,
      required this.images,
      required this.mkey,
      required this.mainImage});

  @override
  State<MemoriesOpen> createState() => _MemoriesOpenState();
}

class _MemoriesOpenState extends State<MemoriesOpen> {
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
                          builder: (context) => MemoriesEdit(
                                title: widget.title,
                                mkey: widget.mkey,
                                images: widget.images,
                                mainImage: widget.mainImage,
                              )));
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
                    MemoriesDb.deleteMemories(widget.mkey);
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          )
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: memoriesNotifier,
        builder: (context, value, child) => GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, mainAxisSpacing: 10, crossAxisSpacing: 10),
          itemCount: widget.images.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) => OpenImage(
                        image: widget.images[index]!,
                        imagesss: widget.images,
                        mainImg: widget.mainImage,
                        title: widget.title,
                        mkey: widget.mkey,
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
    );
  }
}

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:life_leaf/controller/memories_db_functions/memories_db_functions.dart';
import 'package:life_leaf/view/screens/Memorie%20_screen/memories_edit.dart';

class MemoriesOpen extends StatefulWidget {
  final String title;
  final List<String?> images;
  final String mkey;
  final String mainImage;
  const MemoriesOpen(
      {super.key,
      required this.title,
      required this.images,
      required this.mkey, required this.mainImage});

  @override
  State<MemoriesOpen> createState() => _MemoriesOpenState();
}

class _MemoriesOpenState extends State<MemoriesOpen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 62, 62, 62),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: BackButton(
          color: Colors.white,
          onPressed: () {
            Navigator.pushNamed(context, 'home');
          },
        ),
        title: Text(
          widget.title,
          style: TextStyle(
              color: Color.fromARGB(255, 169, 249, 172), fontSize: 20),
        ),
        actions: [
          PopupMenuButton(
            iconColor: Colors.white,
            iconSize: 30,
            itemBuilder: (context) => [
              PopupMenuItem(
                child: ListTile(
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
                child: ListTile(
                  leading: Icon(Icons.delete),
                  title: Text('Delete'),
                ),
                onTap: () {
                  MemoriesDb.deleteMemories(widget.mkey);
                  Navigator.pop(context);
                },
              ),
            ],
          )
        ],
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
        itemCount: widget.images.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: FileImage(File(widget.images[index]!)))),
          );
        },
      ),
    );
  }
}

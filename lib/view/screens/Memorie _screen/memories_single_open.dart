import 'dart:io';

import 'package:flutter/material.dart';
import 'package:life_leaf/controller/memories_db_functions/memories_db_functions.dart';
import 'package:life_leaf/model/memories_model/memories_model.dart';

class OpenImage extends StatefulWidget {
  final String mkey;
  final List<String?> imagesss;
  final String mainImg;
  final String title;
  final String image;
  const OpenImage(
      {super.key,
      required this.image,
      required this.imagesss,
      required this.mainImg,
      required this.title,
      required this.mkey});

  @override
  State<OpenImage> createState() => _OpenImageState();
}

class _OpenImageState extends State<OpenImage> {
  String mainImgs = '';
  List<String?> imagess = [];
  String titlee = '';

  @override
  void initState() {
    // TODO: implement initState
    mainImgs = widget.mainImg;
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
                final updatedmemory = MemoriesModel(
                    mkey: widget.mkey,
                    title: titlee,  
                    images: imagess,
                    mainImage: widget.mainImg);
                MemoriesDb.updateMemories(updatedmemory);
                MemoriesDb.getMemories();
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

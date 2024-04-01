import 'dart:io';
import 'package:flutter/material.dart';
import 'package:life_leaf/controller/memories_db_functions/memories_db_functions.dart';
import 'package:life_leaf/model/memories_model/memories_model.dart';
import 'package:life_leaf/view/widgets/scaffold_messenger.dart';

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
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        actions: [
          IconButton(
              onPressed: () async {
                bool confirmed = await showDeleteConfirmation(context);
                if (confirmed) {
                  imagess.remove(widget.image);
                  final updatedmemory = MemoriesModel(
                      mkey: widget.mkey,
                      title: titlee,
                      images: imagess,
                      mainImage: widget.mainImg);
                  MemoriesDb.updateMemories(updatedmemory);
                  MemoriesDb.getMemories();
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                }
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.white,
              ))
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 67, 67, 64),
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

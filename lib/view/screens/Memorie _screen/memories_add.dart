import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:life_leaf/controller/memories_db_functions/memories_db_functions.dart';
import 'package:life_leaf/model/memories_model/memories_model.dart';
import 'package:life_leaf/view/widgets/scaffold_messenger.dart';

class MemoriesAdd extends StatefulWidget {
  const MemoriesAdd({super.key});

  @override
  State<MemoriesAdd> createState() => _MemoriesAddState();
}

class _MemoriesAddState extends State<MemoriesAdd> {
  final formKey = GlobalKey<FormState>();
  TextEditingController _title = TextEditingController();

  List<String> selectedImages = [];
  String? mainImage;
  final picker = ImagePicker();
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
            confirmation(context);
            // Navigator.pop(context);
          },
        ),
        title: Text(
          'Add Memories',
          style: TextStyle(color: Color.fromARGB(255, 169, 249, 172)),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 50, bottom: 10, top: 10),
                  child: TextFormField(
                    controller: _title,
                    cursorColor: Colors.white,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      labelText: "Title",
                      labelStyle: TextStyle(color: Colors.white),
                      alignLabelWithHint: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the title';
                      }
                      return null;
                    },
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Text(
                  'Add Main Image',
                  style: TextStyle(color: Colors.white),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 385,
                    height: 250,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(5)),
                    child: Stack(
                      children: [
                        mainImage == null
                            ? const Center(
                                child: Text(
                                'Tap to add image',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 202, 202, 202)),
                              ))
                            : Image(
                                fit: BoxFit.fill,
                                image: FileImage(File(mainImage!))),
                        Positioned(
                          top: 180,
                          left: 158,
                          child: FloatingActionButton(
                            backgroundColor: Color.fromARGB(255, 127, 128, 127),
                            foregroundColor: Color.fromARGB(255, 169, 249, 172),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text('Select Image Option'),
                                  actions: [
                                    IconButton(
                                        onPressed: () {
                                          getMainImagesFromCamera();
                                          Navigator.pop(context);
                                        },
                                        icon: Icon(Icons.camera)),
                                    IconButton(
                                        onPressed: () {
                                          getMainImagesFromGallery();
                                          Navigator.pop(context);
                                        },
                                        icon: Icon(Icons.browse_gallery)),
                                  ],
                                ),
                              );
                            },
                            child: Icon(Icons.add),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(70)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Text(
                  'Add Image',
                  style: TextStyle(color: Colors.white),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 385,
                    height: 250,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(5)),
                    child: Stack(
                      children: [
                        selectedImages.isEmpty
                            ? const Center(
                                child: Text(
                                'Tap to add image',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 202, 202, 202)),
                              ))
                            : GridView.builder(
                                itemCount: selectedImages.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3),
                                itemBuilder: (BuildContext context, int index) {
                                  return Center(
                                      child: kIsWeb
                                          ? Image.network(selectedImages[index])
                                          : Image.file(
                                              File(selectedImages[index])));
                                },
                              ),
                        Positioned(
                          top: 180,
                          left: 158,
                          child: FloatingActionButton(
                            backgroundColor: Color.fromARGB(255, 127, 128, 127),
                            foregroundColor: Color.fromARGB(255, 169, 249, 172),
                            onPressed: () {
                              getImages();
                            },
                            child: Icon(Icons.add),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(70)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        backgroundColor: Color.fromARGB(255, 127, 128, 127)),
                    onPressed: () {
                      saveMemoriesToDb();
                    },
                    child: Text(
                      'Save',
                      style: TextStyle(
                        color: Color.fromARGB(255, 169, 249, 172),
                        fontWeight: FontWeight.bold,
                        fontSize: 19,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ]),
      ),
    );
  }

  void confirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Color.fromARGB(255, 113, 191, 117),
        title: const Text('Are you sure?'),
        content: const Text(
          'Do you want to go back?',
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text(
              'No',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pushNamed(context, 'home'),
            child: const Text(
              'Yes',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void saveMemoriesToDb() async {
    String title = _title.text.trim();

    // DateTime date = selectedDate;
    var newMemorieModel = MemoriesModel(
        title: title, images: selectedImages, mainImage: mainImage);
    if (_title.text.isEmpty) {
      showSnackBar(
          backgroundColor: Colors.red,
          context: context,
          textcolor: Colors.white,
          text: "Title is not Added");
    } else {
      // JournalDB.getjournal();
      MemoriesDb.addMemories(newMemorieModel);

      _title.clear();
      MemoriesDb.getMemories();
      Navigator.pop(context);
    }
  }

  Future getImages() async {
    final pickedFile = await picker.pickMultiImage(
        imageQuality: 100, maxHeight: 1000, maxWidth: 1000);
    List<XFile> xfilePick = pickedFile;

    setState(
      () {
        if (xfilePick.isNotEmpty) {
          for (var i = 0; i < xfilePick.length; i++) {
            selectedImages.add(xfilePick[i].path);
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Nothing is selected')));
        }
      },
    );
  }

  Future getMainImagesFromGallery() async {
    final pickedFile = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 100,
        maxHeight: 1000,
        maxWidth: 1000);
    XFile xfilePick = pickedFile!;

    setState(() {
      mainImage = xfilePick.path;
    });
  }

  Future getMainImagesFromCamera() async {
    final pickedFile = await picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 100,
        maxHeight: 1000,
        maxWidth: 1000);
    XFile xfilePick = pickedFile!;

    setState(() {
      mainImage = xfilePick.path;
    });
  }
}

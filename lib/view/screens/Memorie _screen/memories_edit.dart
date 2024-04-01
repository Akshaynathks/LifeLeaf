import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:life_leaf/controller/memories_db_functions/memories_db_functions.dart';
import 'package:life_leaf/model/memories_model/memories_model.dart';
import 'package:life_leaf/view/widgets/scaffold_messenger.dart';

class MemoriesEdit extends StatefulWidget {
  final String title;
  final String mkey;
  final List<String?> images;
  final String mainImage;
  const MemoriesEdit(
      {super.key,
      required this.title,
      required this.mkey,
      required this.images,
      required this.mainImage});

  @override
  State<MemoriesEdit> createState() => _MemoriesEditState();
}

class _MemoriesEditState extends State<MemoriesEdit> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController _title = TextEditingController();

  List<String?> selectedImagess = [];
  String? mainImage;
  final picker = ImagePicker();

  @override
  void initState() {
    _title.text = widget.title;

    selectedImagess = widget.images;
    mainImage = widget.mainImage;
    super.initState();
  }

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
            confirmation(context);
          },
        ),
        title: const Text('Edit Memories',style: TextStyle(color:Color.fromARGB(255, 227, 251, 92), fontSize: 25,fontWeight: FontWeight.w800),),
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
                    decoration: const InputDecoration(
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
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const Text(
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
                            ? Image(image: FileImage(File(widget.mainImage)))
                            : Image(
                                fit: BoxFit.fill,
                                image: FileImage(File(mainImage!))),
                        Positioned(
                          top: 180,
                          left: 158,
                          child: FloatingActionButton(
                            backgroundColor:
                                const Color.fromARGB(255, 127, 128, 127),
                            foregroundColor:
                                const Color.fromARGB(255, 169, 249, 172),
                            onPressed: () {
                              getMainImages();
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(70)),
                            child: const Icon(Icons.add),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Text(
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
                        selectedImagess.isEmpty
                            ? const Center(
                                child: Text('Sorry nothing selected!!'))
                            : GridView.builder(
                                itemCount: selectedImagess.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3),
                                itemBuilder: (BuildContext context, int index) {
                                  return Center(
                                      child: kIsWeb
                                          ? Image.network(
                                              selectedImagess[index]!)
                                          : Image.file(
                                              File(selectedImagess[index]!)));
                                },
                              ),
                        Positioned(
                          top: 180,
                          left: 135,
                          child: FloatingActionButton(
                            backgroundColor:
                                const Color.fromARGB(255, 127, 128, 127),
                            foregroundColor:
                                const Color.fromARGB(255, 169, 249, 172),
                            onPressed: () {
                              getImages();
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(70)),
                            child: const Icon(Icons.add),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        backgroundColor:
                            const Color.fromARGB(255, 127, 128, 127)),
                    onPressed: () {
                      saveMemoriesToDb();
                    },
                    child: const Text(
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
        backgroundColor: const Color.fromARGB(255, 233, 233, 233),
        title: const Text('Are you sure?'),
        content: const Text(
          'Do you want to go back?',
          style: TextStyle(
              color: Color.fromARGB(255, 146, 5, 5),
              fontWeight: FontWeight.bold),
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
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
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
        title: title,
        images: selectedImagess,
        mainImage: mainImage,
        mkey: widget.mkey);
    if (_title.text.isEmpty) {
      showSnackBar(
          backgroundColor: Colors.red,
          context: context,
          textcolor: Colors.white,
          text: "Title is not Added");
    } else {
      // JournalDB.getjournal();
      MemoriesDb.updateMemories(newMemorieModel);

      // _title.clear();

      MemoriesDb.getMemories();
      // Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => Home(),
      //     ));
      Navigator.pop(context);
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
            selectedImagess.add(xfilePick[i].path);
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Nothing is selected')));
        }
      },
    );
  }

  Future getMainImages() async {
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
}

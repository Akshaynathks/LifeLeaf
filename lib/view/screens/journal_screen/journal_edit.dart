import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:life_leaf/controller/journal_db_functions/journals_db_functions.dart';
import 'package:life_leaf/model/journal_model/journal_model.dart';
import 'package:life_leaf/view/widgets/scaffold_messenger.dart';

class journalEdit extends StatefulWidget {
  final String date;
  final String title;
  final String note;
  final String jkey;
  final List<String?> images;
  const journalEdit(
      {super.key,
      required this.date,
      required this.title,
      required this.note,
      required this.jkey,
      required this.images});

  @override
  State<journalEdit> createState() => _journalEditState();
}

class _journalEditState extends State<journalEdit> {
  final formKey = GlobalKey<FormState>();
  TextEditingController _title = TextEditingController();
  TextEditingController _notes = TextEditingController();
  TextEditingController _date = TextEditingController();
  List<String?> selectedImages = [];
  final picker = ImagePicker();

  @override
  void initState() {
    // TODO: implement initState
    _title.text = widget.title;
    _notes.text = widget.note;
    _date.text = widget.date;
    selectedImages = widget.images;
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
        // title: Text(
        //   widget.date,
        //   style: TextStyle(
        //       color: Color.fromARGB(255, 169, 249, 172), fontSize: 15),
        // ),
        title: TextFormField(
          controller: _date,
          keyboardType: TextInputType.datetime,
          decoration: const InputDecoration(
            labelStyle: TextStyle(color: Colors.white),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please fill The date';
            }
            return null;
          },
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
                barrierColor: const Color.fromARGB(255, 169, 249, 172),
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1950),
                //DateTime.now() - not to allow to choose before today.
                lastDate: DateTime(2100));

            if (pickedDate != null) {
              print(
                  pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
              String formattedDate =
                  DateFormat('yyyy-MM-dd').format(pickedDate);
              print(
                  formattedDate); //formatted date output using intl package =>  2021-03-16
              setState(() {
                _date.text =
                    formattedDate; //set output date to TextField value.
              });
            } else {}
          },
          style: const TextStyle(color: Colors.white),
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
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: TextFormField(
                    controller: _notes,
                    cursorColor: Colors.white,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: "Notes",
                      labelStyle: TextStyle(color: Colors.white),
                      alignLabelWithHint: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    ),
                    maxLines: 10,
                    style: const TextStyle(color: Colors.white),
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
                        selectedImages.isEmpty
                            ? const Center(
                                child: Text(
                                'Tap to add images',
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
                                          ? Image.network(
                                              selectedImages[index]!)
                                          : Image.file(
                                              File(selectedImages[index]!)));
                                },
                              ),
                        Positioned(
                          top: 180,
                          left: 158,
                          child: FloatingActionButton(
                            backgroundColor:
                                const Color.fromARGB(255, 127, 128, 127),
                            foregroundColor:
                                const Color.fromARGB(255, 169, 249, 172),
                            onPressed: () {
                              getImages();
                            },
                            child: const Icon(Icons.add),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(70)),
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
                      saveEditedJournalToDb();

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
        backgroundColor: const Color.fromARGB(255, 113, 191, 117),
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

  void saveEditedJournalToDb() async {
    final newJournal = JournalModel(
        journalTitle: _title.text,
        journalNotes: _notes.text,
        journalDate: _date.text,
        journalkey: widget.jkey,
        images: selectedImages);

    JournalDb.updateJournal(newJournal);
    showSnackBar(
        backgroundColor: Colors.green,
        context: context,
        text: 'Successfully Edited',
        textcolor: Colors.white);
    Navigator.pop(context);
    Navigator.pop(context);
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
}

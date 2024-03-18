import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:life_leaf/controller/memories_db_functions/memories_db_functions.dart';
import 'package:life_leaf/model/memories_model/memories_model.dart';
import 'package:life_leaf/view/screens/Memorie%20_screen/memory_open.dart';

class Memories extends StatefulWidget {
  const Memories({super.key});

  @override
  State<Memories> createState() => _MemoriesState();
}

class _MemoriesState extends State<Memories> {
  @override
  void initState() {
    super.initState();
    MemoriesDb.getMemories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 62, 62, 62),
      body: Stack(children: [
        ValueListenableBuilder<List<MemoriesModel>>(
          valueListenable: memoriesNotifier,
          builder: (context, value, child) {
            return value.isNotEmpty
                ? ListView.builder(
                    // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    //   crossAxisCount: 2,
                    //   mainAxisSpacing: 18.0,
                    //   crossAxisSpacing: 8.0,
                    // ),
                    itemCount: value
                        .length, // Adjust this based on your actual item count
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => MemoriesOpen(
                                  title: value[index].title,
                                  images: value[index].images,
                                  mkey: value[index].mkey ?? '',
                                  mainImage: value[index].mainImage ?? '',
                                ),
                              ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: double.infinity,
                            height: 200,
                            // color: Colors.white,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: FileImage(
                                        File(value[index].mainImage!))),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(25)),
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                value[index].title,
                                style: const TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.w900),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  )
                : Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 200,
                        ),
                        Text(
                          'No Memories',
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Times',
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 113, 191, 117)),
                        ),
                        SizedBox(
                          width: 200,
                          child: Text(
                            'Create Your notes and it will show up here',
                            style: TextStyle(
                                fontFamily: 'Courier',
                                color: Color.fromARGB(255, 195, 191, 191)),
                          ),
                        )
                      ],
                    ),
                  );
          },
        ),
        Positioned(
          top: 580,
          left: 280,
          child: FloatingActionButton(
            backgroundColor: Color.fromARGB(255, 127, 128, 127),
            foregroundColor: Color.fromARGB(255, 169, 249, 172),
            onPressed: () {
              Navigator.pushNamed(context, 'addMemories');
            },
            child: Icon(Icons.add),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(70)),
          ),
        ),
      ]),
    );
  }
}

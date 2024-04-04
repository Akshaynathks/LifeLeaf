import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hive/hive.dart';
import 'package:life_leaf/controller/memories_db_functions/memories_db_functions.dart';
import 'package:life_leaf/model/memories_model/memories_model.dart';
import 'package:life_leaf/view/screens/Memorie%20_screen/memory_open.dart';
import 'package:life_leaf/view/widgets/search.dart';

class Memories extends StatefulWidget {
  const Memories({super.key});

  @override
  State<Memories> createState() => _MemoriesState();
}

class _MemoriesState extends State<Memories> {
  bool _isSearchBarVisible = false;
  late Box<MemoriesModel> memoriesBox;
  List<MemoriesModel> searchList = [];
  List<MemoriesModel> allMemories = [];

  // @override
  // void initState() {
  //   super.initState();
  //   MemoriesDb.getMemories();
  //   memoriesBox = Hive.box<MemoriesModel>("memories_details");
  //   allMemories = memoriesBox.values.toList();
  // }
  @override
  void initState() {
    super.initState();
    openBox(); // Call openBox() to open the Hive box
    MemoriesDb.getMemories();
  }

  void openBox() async {
    await Hive.openBox<MemoriesModel>("goal_details");
    memoriesBox = Hive.box<MemoriesModel>("goal_details");
    allMemories = memoriesBox.values.toList();
  }

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 49, 49, 49),
      body: Stack(children: [
        Column(
          children: [
            if (_isSearchBarVisible) // Step 3: Conditionally render the CustomSearchBar
              Positioned(
                top: -5,
                left: 20,
                child: CustomSearchBar(
                  onSearch: (value) async {
                    searchRemainder(value);
                  },
                  searchController: searchController,
                ),
              ),
            Expanded(
              child: ValueListenableBuilder<List<MemoriesModel>>(
                valueListenable: memoriesNotifier,
                builder: (context, value, child) {
                  return searchController.text == ''
                      ? value.isNotEmpty
                          ? ListView.builder(
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
                                            mainImage:
                                                value[index].mainImage ?? '',
                                          ),
                                        ));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Animate(
                                      effects: [FadeEffect(duration: 1000.ms)],
                                      child: Container(
                                        width: double.infinity,
                                        height: 200,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: FileImage(File(
                                                    value[index].mainImage!))),
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Align(
                                          alignment: Alignment.bottomCenter,
                                          child: Animate(
                                            effects: const [
                                              FlipEffect(
                                                  delay: Durations.short4)
                                            ],
                                            child: Text(
                                              value[index].title,
                                              style: const TextStyle(
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.w900,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            )
                          : const Center(
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
                                        color:
                                            Color.fromARGB(255, 113, 191, 117)),
                                  ),
                                  SizedBox(
                                    width: 200,
                                    child: Text(
                                      'Create Your notes and it will show up here',
                                      style: TextStyle(
                                          fontFamily: 'Courier',
                                          color: Color.fromARGB(
                                              255, 195, 191, 191)),
                                    ),
                                  )
                                ],
                              ),
                            )
                      : searchController.text != ''
                          ? value.isNotEmpty
                              ? ListView.builder(
                                  itemCount: searchList
                                      .length, // Adjust this based on your actual item count
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            CupertinoPageRoute(
                                              builder: (context) =>
                                                  MemoriesOpen(
                                                title: searchList[index].title,
                                                images:
                                                    searchList[index].images,
                                                mkey: searchList[index].mkey ??
                                                    '',
                                                mainImage: searchList[index]
                                                        .mainImage ??
                                                    '',
                                              ),
                                            ));
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Animate(
                                          effects: [
                                            FadeEffect(duration: 1000.ms)
                                          ],
                                          child: Container(
                                            width: double.infinity,
                                            height: 200,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: FileImage(File(
                                                        value[index]
                                                            .mainImage!))),
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Animate(
                                                effects: const [
                                                  FlipEffect(
                                                      delay: Durations.short4)
                                                ],
                                                child: Text(
                                                  value[index].title,
                                                  style: const TextStyle(
                                                      fontSize: 25,
                                                      fontWeight:
                                                          FontWeight.w900,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                )
                              : const Center(
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
                                            color: Color.fromARGB(
                                                255, 113, 191, 117)),
                                      ),
                                      SizedBox(
                                        width: 200,
                                        child: Text(
                                          'Create Your notes and it will show up here',
                                          style: TextStyle(
                                              fontFamily: 'Courier',
                                              color: Color.fromARGB(
                                                  255, 195, 191, 191)),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                          : const Center(
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
                                        color:
                                            Color.fromARGB(255, 113, 191, 117)),
                                  ),
                                  SizedBox(
                                    width: 200,
                                    child: Text(
                                      'Create Your notes and it will show up here',
                                      style: TextStyle(
                                          fontFamily: 'Courier',
                                          color: Color.fromARGB(
                                              255, 195, 191, 191)),
                                    ),
                                  )
                                ],
                              ),
                            );
                },
              ),
            ),
          ],
        ),
        Positioned(
          top: 580,
          left: 280,
          child: FloatingActionButton(
            backgroundColor: const Color.fromARGB(255, 127, 128, 127),
            foregroundColor: const Color.fromARGB(255, 169, 249, 172),
            onPressed: () {
              Navigator.pushNamed(context, 'addMemories');
            },
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(70)),
            child: const Icon(Icons.add),
          ),
        ),
        Positioned(
          top: -10,
          right: -3,
          child: Row(
            children: [
              SizedBox(
                width: 40,
                height: 60,
                child: Builder(
                  builder: (context) {
                    return ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            const MaterialStatePropertyAll(Colors.transparent),
                        shape: MaterialStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        padding: const MaterialStatePropertyAll(
                          EdgeInsets.only(left: 3, top: 8),
                        ),
                      ),
                      onPressed: () {
                        setState(() {
                          _isSearchBarVisible =
                              !_isSearchBarVisible; // Toggle visibility
                        });
                      },
                      child: const Icon(
                        Icons.search_sharp,
                        color: Colors.white,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }

  searchRemainder(String value) async {
    setState(() {
      searchList = allMemories
          .where((element) =>
              element.title.toLowerCase().startsWith(value.toLowerCase()))
          .toList();
    });
  }
}

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:life_leaf/controller/reminder_db_functions/reminder_db_functions.dart';
import 'package:life_leaf/model/reminder_model/reminder_model.dart';
import 'package:life_leaf/view/screens/reminder_screen/widgets/reminder_card_widget.dart';
import 'package:life_leaf/view/widgets/search.dart';

class Reminder extends StatefulWidget {
  const Reminder({super.key});

  @override
  State<Reminder> createState() => _ReminderState();
}

class _ReminderState extends State<Reminder> {
  bool _isSearchBarVisible = false;
  late Box<ReminderModel> remainderBox;
  List<ReminderModel> searchList = [];
  List<ReminderModel> allRemainder = [];

  @override
  void initState() {
    super.initState();
    ReminderDb.getReminder();
    remainderBox = Hive.box<ReminderModel>("reminder_details");
    allRemainder = remainderBox.values.toList();
  }

  TextEditingController searchController = TextEditingController();
  // late Future<Box<ReminderModel>> remainderBoxFuture;
  // List<ReminderModel> searchList = [];
  // List<ReminderModel> allRemainder = [];

  // @override
  // void initState() {
  //   super.initState();
  //   ReminderDb.getReminder();
  //   _initializeReminderBox();
  // }

  // Future<void> _initializeReminderBox() async {
  //   await Hive.initFlutter();
  //   remainderBoxFuture =
  //       Hive.box("reminder_details") as Future<Box<ReminderModel>>;
  //   final box = await remainderBoxFuture;
  //   allRemainder = box.values.toList();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 49, 49, 49),
      body: Stack(
        children: [
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
                child: ValueListenableBuilder<List<ReminderModel>>(
                  valueListenable: reminderNotifier,
                  builder: (context, value, child) {
                    return searchController.text == ''
                        ? ListView.builder(
                            itemCount: value
                                .length, // Adjust this based on your actual item count
                            itemBuilder: (context, index) {
                              var fullDate = value[index].date ?? "d";
                              var thisDate = fullDate.split('-');
                              var month = thisDate.elementAt(1);
                              if (month == '01') {
                                month = 'Jan';
                              }
                              if (month == '02') {
                                month = 'Feb';
                              }
                              if (month == '03') {
                                month = 'Mar';
                              }
                              if (month == '04') {
                                month = 'Apr';
                              }
                              if (month == '05') {
                                month = 'May';
                              }
                              if (month == '06') {
                                month = 'Jun';
                              }
                              if (month == '07') {
                                month = 'Jul';
                              }
                              if (month == '08') {
                                month = 'Aug';
                              }
                              if (month == '09') {
                                month = 'Sep';
                              }
                              if (month == '10') {
                                month = 'Oct';
                              }
                              if (month == '11') {
                                month = 'Nov';
                              }
                              if (month == '12') {
                                month = 'Dec';
                              }

                              var hourr = thisDate.elementAt(3);
                              dynamic AP;

                              if (hourr == ' 13' ||
                                  hourr == ' 14' ||
                                  hourr == ' 15' ||
                                  hourr == ' 16' ||
                                  hourr == ' 17' ||
                                  hourr == ' 18' ||
                                  hourr == ' 19' ||
                                  hourr == ' 20' ||
                                  hourr == ' 21' ||
                                  hourr == ' 22' ||
                                  hourr == ' 23' ||
                                  hourr == ' 24') {
                                AP = 'PM';
                              } else {
                                AP = 'AM';
                              }

                              var hour = thisDate.elementAt(3);
                              if (hour == ' 13') {
                                hour = '01';
                              } else if (hour == ' 14') {
                                hour = '02';
                              } else if (hour == ' 15') {
                                hour = '03';
                              } else if (hour == ' 16') {
                                hour = '04';
                              } else if (hour == ' 17') {
                                hour = '05';
                              } else if (hour == ' 18') {
                                hour = '06';
                              } else if (hour == ' 19') {
                                hour = '07';
                              } else if (hour == ' 20') {
                                hour = '08';
                              } else if (hour == ' 21') {
                                hour = '09';
                              } else if (hour == ' 22') {
                                hour = '10';
                              } else if (hour == ' 23') {
                                hour = '11';
                              } else if (hour == ' 00') {
                                hour = '12';
                              }

                              var datee =
                                  '${thisDate.first} $month ${thisDate.elementAt(2)} ${hour.trim()}:${thisDate.elementAt(4)} $AP';
                              return ReminderCardWidget(
                                  title: value[index].title,
                                  // date: value[index].date ?? '',
                                  date: datee,
                                  descr: value[index].description,
                                  rkey: value[index].rkey ?? '');
                            },
                          )
                        : searchController.text != ''
                            ? ListView.builder(
                                itemCount: searchList
                                    .length, // Adjust this based on your actual item count
                                itemBuilder: (context, index) {
                                  var fullDate = searchList[index].date ?? "d";
                                  var thisDate = fullDate.split('-');
                                  var month = thisDate.elementAt(1);
                                  if (month == '01') {
                                    month = 'Jan';
                                  }
                                  if (month == '02') {
                                    month = 'Feb';
                                  }
                                  if (month == '03') {
                                    month = 'Mar';
                                  }
                                  if (month == '04') {
                                    month = 'Apr';
                                  }
                                  if (month == '05') {
                                    month = 'May';
                                  }
                                  if (month == '06') {
                                    month = 'Jun';
                                  }
                                  if (month == '07') {
                                    month = 'Jul';
                                  }
                                  if (month == '08') {
                                    month = 'Aug';
                                  }
                                  if (month == '09') {
                                    month = 'Sep';
                                  }
                                  if (month == '10') {
                                    month = 'Oct';
                                  }
                                  if (month == '11') {
                                    month = 'Nov';
                                  }
                                  if (month == '12') {
                                    month = 'Dec';
                                  }

                                  var hourr = thisDate.elementAt(3);
                                  dynamic AP;

                                  if (hourr == ' 13' ||
                                      hourr == ' 14' ||
                                      hourr == ' 15' ||
                                      hourr == ' 16' ||
                                      hourr == ' 17' ||
                                      hourr == ' 18' ||
                                      hourr == ' 19' ||
                                      hourr == ' 20' ||
                                      hourr == ' 21' ||
                                      hourr == ' 22' ||
                                      hourr == ' 23' ||
                                      hourr == ' 24') {
                                    AP = 'PM';
                                  } else {
                                    AP = 'AM';
                                  }

                                  var hour = thisDate.elementAt(3);
                                  if (hour == ' 13') {
                                    hour = '01';
                                  } else if (hour == ' 14') {
                                    hour = '02';
                                  } else if (hour == ' 15') {
                                    hour = '03';
                                  } else if (hour == ' 16') {
                                    hour = '04';
                                  } else if (hour == ' 17') {
                                    hour = '05';
                                  } else if (hour == ' 18') {
                                    hour = '06';
                                  } else if (hour == ' 19') {
                                    hour = '07';
                                  } else if (hour == ' 20') {
                                    hour = '08';
                                  } else if (hour == ' 21') {
                                    hour = '09';
                                  } else if (hour == ' 22') {
                                    hour = '10';
                                  } else if (hour == ' 23') {
                                    hour = '11';
                                  } else if (hour == ' 00') {
                                    hour = '12';
                                  }

                                  var datee =
                                      '${thisDate.first} $month ${thisDate.elementAt(2)} ${hour.trim()}:${thisDate.elementAt(4)} $AP';
                                  return ReminderCardWidget(
                                      title: searchList[index].title,
                                      // date: searchList[index].date ?? '',
                                      date: datee,
                                      descr: searchList[index].description,
                                      rkey: searchList[index].rkey ?? '');
                                },
                              )
                            : const Center(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 200,
                                    ),
                                    Text(
                                      'No Reminder',
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
                                        'Create Your Reminder and it will show up here',
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
            top: 560,
            left: 280,
            child: FloatingActionButton(
              backgroundColor: const Color.fromARGB(255, 127, 128, 127),
              foregroundColor: const Color.fromARGB(255, 169, 249, 172),
              onPressed: () {
                Navigator.pushNamed(context, 'addreminder');
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(70)),
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
                          backgroundColor: const MaterialStatePropertyAll(
                              Color.fromRGBO(0, 0, 0, 1)),
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
        ],
      ),
    );
  }

  searchRemainder(String value) async {
    setState(() {
      searchList = allRemainder
          .where((element) =>
              element.title.toLowerCase().startsWith(value.toLowerCase()) ||
              element.date!.startsWith(value))
          .toList();
    });
  }
}

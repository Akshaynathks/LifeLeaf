import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:life_leaf/controller/habit_db_functions/habit_db_functions.dart';
import 'package:life_leaf/model/habit_model/habit_model.dart';
import 'package:life_leaf/view/screens/habit_screen/widgets/habit_card_widget.dart';
import 'package:life_leaf/view/widgets/search.dart';

class Habit extends StatefulWidget {
  const Habit({super.key});

  @override
  State<Habit> createState() => _HabitState();
}

class _HabitState extends State<Habit> {
  TextEditingController titleController = TextEditingController();
  bool _isSearchBarVisible = false;
  late Box<HabitModel> habitBox;
  List<HabitModel> searchList = [];
  List<HabitModel> allHabits = [];

  // @override
  // void initState() {
  //   super.initState();
  //   HabitDb.getHabit();
  //   habitBox = Hive.box<HabitModel>("habit_details");
  //   allHabits = habitBox.values.toList();
  // }
  @override
  void initState() {
    super.initState();
    openBox(); // Call openBox() to open the Hive box
    HabitDb.getHabit();
  }

  void openBox() async {
    await Hive.openBox<HabitModel>("goal_details");
    habitBox = Hive.box<HabitModel>("goal_details");
    allHabits = habitBox.values.toList();
  }

  TextEditingController searchController = TextEditingController();
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
                child: ValueListenableBuilder<List<HabitModel>>(
                  valueListenable: habitNotifier,
                  builder: (context, value, child) {
                    return searchController.text == ''
                        ? value.isNotEmpty
                            ? ListView.builder(
                                itemCount: value
                                    .length, // Adjust this based on your actual item count
                                itemBuilder: (context, index) {
                                  return HabitCardWidget(
                                    title: value[index].title,
                                    maxcompleate: value[index].maxCompleated,
                                    maxskipped: value[index].maxSkipped,
                                    hkey: value[index].hkey ?? '',
                                  ); // You can modify this to display data based on the index
                                },
                              )
                            : const Center(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 200,
                                    ),
                                    Text(
                                      'No Habits',
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
                                        'Create a Habit and it will show up hear',
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
                                      return HabitCardWidget(
                                        title: searchList[index].title,
                                        maxcompleate:
                                            searchList[index].maxCompleated,
                                        maxskipped:
                                            searchList[index].maxSkipped,
                                        hkey: searchList[index].hkey ?? '',
                                      ); // You can modify this to display data based on the index
                                    },
                                  )
                                : const Center(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 200,
                                        ),
                                        Text(
                                          'No Habits',
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
                                            'Create a Habit and it will show up hear',
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
                                      'No Habits',
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
                                        'Create a Habit and it will show up hear',
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
                _showAddHabitDialog(context);
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
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
                              Colors.transparent),
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
      searchList = allHabits
          .where((element) =>
              element.title.toLowerCase().startsWith(value.toLowerCase()))
          .toList();
    });
  }
}

void _showAddHabitDialog(BuildContext context) {
  final TextEditingController habitController = TextEditingController();
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            backgroundColor: const Color.fromARGB(255, 127, 128, 127),
            title: Animate(
              effects: [FadeEffect(duration: 800.ms)],
              child: const Text(
                'Add Habit',
                style: TextStyle(
                  color: Color.fromARGB(255, 231, 247, 88),
                  fontFamily: 'Times',
                ),
              ),
            ),
            content: TextFormField(
              cursorColor: Colors.white,
              controller: habitController,
              decoration: const InputDecoration(
                labelText: 'Habit Name',
                labelStyle: TextStyle(color: Colors.white),
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
              style: const TextStyle(color: Colors.white),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                      color: Colors.black, fontFamily: 'Times', fontSize: 15),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    backgroundColor: const Color.fromARGB(255, 182, 182, 182)),
                onPressed: () {
                  // Trim the text to remove leading and trailing whitespaces
                  String title = habitController.text.trim();

                  // Check if title is empty
                  if (title.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Title cannot be empty",
                          style: TextStyle(color: Colors.white)),
                      backgroundColor: Colors.red,
                    ));
                    return;
                  }
                  String formatDate(DateTime dateTime) {
                    return DateFormat('yyyy/MM/dd').format(dateTime);
                  }

                  String formattedDate = formatDate(DateTime.now());
                  final habit = HabitModel(
                      title: title,
                      maxCompleated: [],
                      maxSkipped: formattedDate);
                  HabitDb.addHabit(habit);
                  HabitDb.getHabit();
                  Navigator.of(context).pop(); // Close the dialog
                },
                // onPressed: () {
                //   final habit = HabitModel(
                //       title: habitController.text,
                //       maxCompleated: '',
                //       maxSkipped: '');
                //   HabitDb.addHabit(habit);
                //   HabitDb.getHabit();
                //   Navigator.of(context).pop(); // Close the dialog
                // },
                child: const Text(
                  'Add',
                  style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontFamily: 'Times',
                      fontSize: 15),
                ),
              ),
            ]);
      });
}

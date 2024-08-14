import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:life_leaf/controller/goals_db_functions/goals_db_functions.dart';
import 'package:life_leaf/model/goals_model/goals_main_model.dart';
import 'package:life_leaf/view/screens/goals_screen/widgets/goal_card_widget.dart';
import 'package:life_leaf/view/widgets/search.dart';

class Goals extends StatefulWidget {
  const Goals({Key? key}) : super(key: key);

  @override
  State<Goals> createState() => _GoalsState();
}

class _GoalsState extends State<Goals> {
  bool _isSearchBarVisible = false;
  late Box<GoalsMainModel> goalsBox;
  List<GoalsMainModel> searchList = [];
  List<GoalsMainModel> allGoals = [];

  @override
  // void initState() {
  //   super.initState();
  //   GoalDb.getGoals();
  //   goalsBox = Hive.box<GoalsMainModel>("goal_details");
  //   allGoals = goalsBox.values.toList();
  // }
  @override
  void initState() {
    super.initState();
    openBox(); // Call openBox() to open the Hive box
    GoalDb.getGoals();
  }

  void openBox() async {
    await Hive.openBox<GoalsMainModel>("goal_details");
    goalsBox = Hive.box<GoalsMainModel>("goal_details");
    allGoals = goalsBox.values.toList();
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
                child: ValueListenableBuilder<List<GoalsMainModel>>(
                  valueListenable: goalsNotifier,
                  builder: (context, value, child) {
                    return searchController.text == ''
                        ? value.isNotEmpty
                            ? ListView.builder(
                                itemCount: value
                                    .length, // Adjust this based on your actual item count
                                itemBuilder: (context, index) {
                                  return GoalsCardWidget(
                                    title: value[index].goalTitle ?? '',
                                    stepss: value[index].goalList,
                                    mainKey: value[index].key ?? '',
                                    goal: value[index],
                                    stepkey: value[index].goalList[0].key ?? '',
                                    isMarked: value[index].isMarked ?? 0,
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
                                      'No Goals',
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
                                        'Create Your Goals and it will show up here',
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
                                      return GoalsCardWidget(
                                        title:
                                            searchList[index].goalTitle ?? '',
                                        stepss: searchList[index].goalList,
                                        mainKey: searchList[index].key ?? '',
                                        goal: searchList[index],
                                        stepkey:
                                            searchList[index].goalList[0].key ??
                                                '',
                                        isMarked:
                                            searchList[index].isMarked ?? 0,
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
                                          'No Goals',
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
                                            'Create Your Goals and it will show up here',
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
                                      'No Goals',
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
                                        'Create Your Goals and it will show up here',
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
                Navigator.pushNamed(context, 'addGoal');
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
                          backgroundColor: const WidgetStatePropertyAll(
                              Colors.transparent),
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          padding: const WidgetStatePropertyAll(
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
      searchList = allGoals
          .where((element) =>
              element.goalTitle!.toLowerCase().startsWith(value.toLowerCase()))
          .toList();
    });
  }
}

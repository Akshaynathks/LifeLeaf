import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:life_leaf/controller/goals_db_functions/goals_db_functions.dart';
import 'package:life_leaf/model/goals_model/goals_main_model.dart';
import 'package:life_leaf/view/screens/goals_screen/widgets/goal_card_widget.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    Key? key,
    required this.onSearch,
  }) : super(key: key);

  final void Function(String) onSearch;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 50,
        width: 500,
        child: CupertinoSearchTextField(
          backgroundColor: Color.fromARGB(255, 127, 128, 127),
          prefixIcon:
              Icon(Icons.search, color: Color.fromARGB(255, 169, 249, 172)),
          placeholder: 'Search...',
          itemColor: Color.fromARGB(255, 169, 249, 172),
          style: TextStyle(color: Colors.white),
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          borderRadius: BorderRadius.circular(10.0),
          onSubmitted: onSearch,
        ),
      ),
    );
  }
}

class Goals extends StatefulWidget {
  const Goals({Key? key}) : super(key: key);

  @override
  State<Goals> createState() => _GoalsState();
}

class _GoalsState extends State<Goals> {
  // late List<GoalsMainModel> allJournals = goalsNotifier.value;
  // late List<GoalsMainModel> filteredJournals = [];

  void initState() {
    super.initState();
    GoalDb.getGoals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 62, 62, 62),
      body: Stack(
        children: [
          ValueListenableBuilder<List<GoalsMainModel>>(
            valueListenable: goalsNotifier,
            builder: (context, value, child) {
              return value.isNotEmpty
                  ? ListView.builder(
                      itemCount: value
                          .length, // Adjust this based on your actual item count
                      itemBuilder: (context, index) {
                        return GoalsCardWidget(
                          title: value[index].goalTitle ?? '',
                          stepss: value[index].goalList,
                          mainKey: value[index].key ?? '',
                        ); // You can modify this to display data based on the index
                      },
                    )
                  : Center(
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
                                color: Color.fromARGB(255, 113, 191, 117)),
                          ),
                          SizedBox(
                            width: 200,
                            child: Text(
                              'Create Your Goals and it will show up here',
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
                Navigator.pushNamed(context, 'addGoal');
              },
              child: Icon(Icons.add),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(70)),
            ),
          ),
        ],
      ),
    );
  }
}

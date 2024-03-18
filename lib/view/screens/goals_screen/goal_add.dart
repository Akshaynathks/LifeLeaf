import 'package:flutter/material.dart';
import 'package:life_leaf/controller/goals_db_functions/goals_db_functions.dart';
import 'package:life_leaf/model/goals_model/goals_main_model.dart';
import 'package:life_leaf/model/goals_model/goals_model.dart';
import 'package:life_leaf/view/screens/goals_screen/widgets/goals_textfield_widget.dart';

class AddGoal extends StatefulWidget {
  const AddGoal({Key? key}) : super(key: key);

  @override
  State<AddGoal> createState() => _AddGoalState();
}

class _AddGoalState extends State<AddGoal> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _title = TextEditingController();
  TextEditingController _steps = TextEditingController();
  TextEditingController _date = TextEditingController();
  TextEditingController mainTitleController = TextEditingController();
  List<GoalsModel> goalsList = [];

  int currentStep = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: BackButton(
          onPressed: () {
            confirmation(context);
          },
        ),
        title: Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            'Create Goal',
            style: TextStyle(
                fontSize: 30,
                fontFamily: 'Times',
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 145, 233, 151)),
          ),
        ),
      ),
      backgroundColor: Color.fromARGB(255, 62, 62, 62),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                controller: mainTitleController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Main Title",
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter The title';
                  }
                  return null;
                },
                style: TextStyle(color: Colors.white),
              ),
            ),
            GoalsTextFieldWidget(
              titleController: _title,
              descriptionController: _steps,
              dateController: _date,
              step: 'Step $currentStep',
              formkey: _formKey,
            ),
            Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 150),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      FloatingActionButton(
                        child: Icon(Icons.add),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(60)),
                        backgroundColor:
                            const Color.fromARGB(255, 112, 224, 116),
                        foregroundColor: Colors.white,
                        onPressed: () {
                          _addStep();
                          // print(goalsList[0].description);
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 50, right: 25),
                        child: ElevatedButton(
                          onPressed: () {
                            if (goalsList.isNotEmpty) {
                              final newGoal = GoalsMainModel(
                                  goalTitle: mainTitleController.text,
                                  goalList: goalsList);
                              _addStep();
                              GoalDb.addGoal(newGoal);
                              GoalDb.getGoals();
                              Navigator.pop(context);
                            } else {
                              goalsList.add(GoalsModel(
                                title: _title.text,
                                description: _steps.text,
                                targetDate: _date.text,
                                step: 'Step $currentStep',
                              ));
                              final newGoal = GoalsMainModel(
                                  goalList: goalsList,
                                  goalTitle: mainTitleController.text);

                              GoalDb.addGoal(newGoal);
                              GoalDb.getGoals();
                              Navigator.pop(context);
                            }
                          },
                          child: Text(
                            'Save',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void _addStep() {
    if (_formKey.currentState!.validate()) {
      goalsList.add(GoalsModel(
        title: _title.text,
        description: _steps.text,
        targetDate: _date.text,
        step: 'Step $currentStep',
      ));

      _title.clear();
      _steps.clear();
      _date.clear();

      setState(() {
        currentStep++;
      });
    }
  }

  void confirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Color.fromARGB(255, 113, 191, 117),
        title: const Text('Are you sure?'),
        content: const Text(
          'Do you want to cancel?',
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
                  fontSize: 20),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pushNamed(context, 'home'),
            child: const Text(
              'Yes',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}

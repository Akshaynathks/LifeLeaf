import 'package:flutter/material.dart';
import 'package:life_leaf/controller/goals_db_functions/goals_db_functions.dart';
import 'package:life_leaf/model/goals_model/goals_main_model.dart';
import 'package:life_leaf/model/goals_model/goals_model.dart';
import 'package:life_leaf/view/screens/goals_screen/widgets/edit_goals_text_field_widget.dart';
import 'package:life_leaf/view/screens/goals_screen/widgets/goals_textfield_widget.dart';

// class EditGoal extends StatefulWidget {
//   final String title;
//   final List<GoalsModel> stepss;
//   final String mainGoalkey;
//   final GoalsMainModel goal;
//   final String stepkey;
//   // final String goalTitle;
//   const EditGoal({
//     Key? key,
//     required this.stepss,
//     required this.title,
//     required this.mainGoalkey,
//     required this.goal,
//     required this.stepkey,
//   }) : super(key: key);

//   @override
//   State<EditGoal> createState() => _EditGoalState();
// }

// class _EditGoalState extends State<EditGoal> {
//   final _formKey = GlobalKey<FormState>();
//   TextEditingController _mainTitleController = TextEditingController();
//   List<TextEditingController> _titleControllers = [];
//   List<TextEditingController> _descriptionControllers = [];
//   List<TextEditingController> _dateControllers = [];
//   List<GoalsModel> goalsList = [];
//   List<GoalsModel> newgoalsList = [];

//   int currentStep = 1;

//   @override
//   void initState() {
//     super.initState();
//     goalsList = widget.goal.goalList;
//     _mainTitleController.text = widget.title;
//     _initializeControllers();
//   }

//   void _initializeControllers() {
//     for (final step in goalsList) {
//       _titleControllers.add(TextEditingController(text: step.title));
//       _descriptionControllers
//           .add(TextEditingController(text: step.description));
//       _dateControllers.add(TextEditingController(text: step.targetDate));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     goalsList = widget.stepss;
//     print(widget.stepss.length);
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.transparent,
//         leading: BackButton(
//           onPressed: () {
//             confirmation(context);
//           },
//         ),
//         title: Padding(
//           padding: EdgeInsets.only(left: 20),
//           child: Text(
//             'Create Goal',
//             style: TextStyle(
//                 fontSize: 30,
//                 fontFamily: 'Times',
//                 fontWeight: FontWeight.bold,
//                 color: Color.fromARGB(255, 145, 233, 151)),
//           ),
//         ),
//       ),
//       backgroundColor: Color.fromARGB(255, 62, 62, 62),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(left: 20, right: 20),
//               child: TextFormField(
//                 controller: _mainTitleController,
//                 keyboardType: TextInputType.text,
//                 decoration: InputDecoration(
//                   labelText: "Main Title",
//                   labelStyle: TextStyle(color: Colors.white),
//                   enabledBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.white),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.white),
//                   ),
//                   errorBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.red),
//                   ),
//                   focusedErrorBorder: OutlineInputBorder(
//                     borderSide: BorderSide(color: Colors.red),
//                   ),
//                 ),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter The title';
//                   }
//                   return null;
//                 },
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//             SizedBox(
//               height: 350,
//               child: ListView.builder(
//                 itemCount: goalsList.length,
//                 itemBuilder: (context, index) => EditGoalsTextFieldWidget(
//                   titleController: _titleControllers[index],
//                   descriptionController: _descriptionControllers[index],
//                   dateController: _dateControllers[index],
//                   updateTitle: (title) =>
//                       setState(() => goalsList[index].title = title),
//                   updateDescription: (description) =>
//                       setState(() => goalsList[index].description),
//                   // updateDate: (date) => setState(() => goalsList[index].targetDate = date),
//                   step: goalsList[index].step ?? '',
//                   ondelete: () {
//                     print(goalsList[index].key);
//                     GoalDb.deleteGoalStep(goalsList[index].key ?? '');
//                   },
//                 ),
//               ),
//             ),
//             Stack(
//               children: [
//                 Padding(
//                   padding: EdgeInsets.only(top: 150),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       // FloatingActionButton(
//                       //   child: Icon(Icons.add),
//                       //   shape: RoundedRectangleBorder(
//                       //       borderRadius: BorderRadius.circular(60)),
//                       //   backgroundColor:
//                       //       const Color.fromARGB(255, 112, 224, 116),
//                       //   foregroundColor: Colors.white,
//                       //   onPressed: () {
//                       //     // _addStep();
//                       //     _addNewTextField();
//                       //     // print(goalsList[0].description);
//                       //   },
//                       // ),
//                       Padding(
//                         padding: EdgeInsets.only(left: 50, right: 25),
//                         child: ElevatedButton(
//                           onPressed: () {
//                             for (var i = 0; i < goalsList.length; i++) {

//                             }
//                             if (goalsList.isNotEmpty) {
//                               final newGoal = GoalsMainModel(
//                                   goalTitle: _mainTitleController.text,
//                                   goalList: goalsList,
//                                   key: widget.mainGoalkey);
//                               // _addNewTextField();
//                               // _addNewTextField();
//                               // GoalDb.updateGoalStep(newGoal);
//                               GoalDb.updateGoal(newGoal);
//                               GoalDb.getGoals();
//                               Navigator.pop(context);
//                             } else {
//                               goalsList.add(GoalsModel(
//                                 title: _titleControllers[0].text,
//                                 description: _descriptionControllers[0].text,
//                                 targetDate: _dateControllers[0].text,
//                                 step: 'Step $currentStep',
//                               ));
//                               final newGoal = GoalsMainModel(
//                                   goalList: goalsList,
//                                   goalTitle: _mainTitleController.text,
//                                   key: widget.mainGoalkey);
//                               // GoalDb.updateGoalStep(newGoal);
//                               GoalDb.updateGoal(newGoal);
//                               GoalDb.getGoals();
//                               Navigator.pop(context);
//                             }
//                           },
//                           child: Text(
//                             'Save',
//                             style: TextStyle(
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 18),
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 )
//               ],
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   void confirmation(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         backgroundColor: Color.fromARGB(255, 113, 191, 117),
//         title: const Text('Are you sure?'),
//         content: const Text(
//           'Do you want to cancel?',
//           style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context, false),
//             child: const Text(
//               'No',
//               style: TextStyle(
//                   color: Colors.black,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 20),
//             ),
//           ),
//           TextButton(
//             onPressed: () => Navigator.pushNamed(context, 'home'),
//             child: const Text(
//               'Yes',
//               style: TextStyle(
//                   color: Colors.black,
//                   fontWeight: FontWeight.bold,
//                   fontSize: 20),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
import 'package:flutter/material.dart';
import 'package:life_leaf/controller/goals_db_functions/goals_db_functions.dart';
import 'package:life_leaf/model/goals_model/goals_main_model.dart';
import 'package:life_leaf/model/goals_model/goals_model.dart';
import 'package:life_leaf/view/screens/goals_screen/widgets/edit_goals_text_field_widget.dart';
import 'package:life_leaf/view/screens/goals_screen/widgets/goals_textfield_widget.dart';

class EditGoal extends StatefulWidget {
  final String title;
  final List<GoalsModel> stepss;
  final String mainGoalkey;
  final GoalsMainModel goal;
  final String stepkey;

  const EditGoal({
    Key? key,
    required this.stepss,
    required this.title,
    required this.mainGoalkey,
    required this.goal,
    required this.stepkey,
  }) : super(key: key);

  @override
  State<EditGoal> createState() => _EditGoalState();
}

class _EditGoalState extends State<EditGoal> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _mainTitleController = TextEditingController();
  List<TextEditingController> _titleControllers = [];
  List<TextEditingController> _descriptionControllers = [];
  List<TextEditingController> _dateControllers = [];
  List<GoalsModel> goalsList = [];
  List<GoalsModel> newgoalsList = [];

  int currentStep = 1;

  @override
  void initState() {
    super.initState();
    goalsList = widget.goal.goalList;
    _mainTitleController.text = widget.title;
    _initializeControllers();
  }

  void _initializeControllers() {
    for (final step in goalsList) {
      _titleControllers.add(TextEditingController(text: step.title));
      _descriptionControllers
          .add(TextEditingController(text: step.description));
      _dateControllers.add(TextEditingController(text: step.targetDate));
    }
  }

  @override
  Widget build(BuildContext context) {
    goalsList = widget.stepss;
    print(widget.stepss.length);
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
                controller: _mainTitleController,
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
            SizedBox(
              height: 350,
              child: ListView.builder(
                itemCount: goalsList.length,
                itemBuilder: (context, index) => EditGoalsTextFieldWidget(
                  titleController: _titleControllers[index],
                  descriptionController: _descriptionControllers[index],
                  dateController: _dateControllers[index],
                  updateTitle: (title) =>
                      setState(() => goalsList[index].title = title),
                  updateDescription: (description) =>
                      setState(() => goalsList[index].description),
                  // updateDate: (date) => setState(() => newgoalsList[index].targetDate = date),
                  step: goalsList[index].step ?? '',
                  ondelete: () {
                    print(goalsList[index].key);
                    GoalDb.deleteGoalStep(goalsList[index].key ?? '');
                  },
                ),
              ),
            ),
            Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 150),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 50, right: 25),
                        child: ElevatedButton(
                          onPressed: () {
                            for (var i = 0; i < goalsList.length; i++) {
                              // Update newgoalsList with the modified values from goalsList
                              newgoalsList.add(GoalsModel(
                                title: _titleControllers[i].text,
                                description: _descriptionControllers[i].text,
                                targetDate: _dateControllers[i].text,
                                step: 'Step ${i + 1}',
                              ));
                            }
                            if (newgoalsList.isNotEmpty) {
                              final newGoal = GoalsMainModel(
                                goalTitle: _mainTitleController.text,
                                goalList: newgoalsList,
                                key: widget.mainGoalkey,
                              );
                              GoalDb.updateGoal(newGoal);
                              GoalDb.getGoals();
                              Navigator.pop(context);
                              Navigator.pop(context);
                            }
                          },
                          // onPressed: () {
                          //   for (var i = 0; i < newgoalsList.length; i++) {}
                          //   if (newgoalsList.isNotEmpty) {
                          //     final newGoal = GoalsMainModel(
                          //         goalTitle: _mainTitleController.text,
                          //         goalList: newgoalsList,
                          //         key: widget.mainGoalkey);
                          //     GoalDb.updateGoal(newGoal);
                          //     GoalDb.getGoals();
                          //     Navigator.pop(context);
                          //   } else {
                          //     newgoalsList.add(GoalsModel(
                          //       title: _titleControllers[0].text,
                          //       description: _descriptionControllers[0].text,
                          //       targetDate: _dateControllers[0].text,
                          //       step: 'Step $currentStep',
                          //     ));
                          //     final newGoal = GoalsMainModel(
                          //         goalList: newgoalsList,
                          //         goalTitle: _mainTitleController.text,
                          //         key: widget.mainGoalkey);
                          //     GoalDb.updateGoal(newGoal);
                          //     GoalDb.getGoals();
                          //     Navigator.pop(context);
                          //     Navigator.pop(context);
                          //   }
                          // },
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

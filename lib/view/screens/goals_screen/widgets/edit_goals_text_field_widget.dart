import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditGoalsTextFieldWidget extends StatefulWidget {
  // final TextEditingController titleController;
  // final TextEditingController descriptionController;
  // final TextEditingController dateController;
  final String step;
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TextEditingController dateController;
  final Function(String) updateTitle;
  final Function(String) updateDescription;
  final void Function() ondelete;

  const EditGoalsTextFieldWidget({
    super.key,
    required this.titleController,
    required this.descriptionController,
    required this.dateController,
    required this.updateTitle,
    required this.updateDescription,
    required this.step,
    required this.ondelete,
  });
  @override
  State<EditGoalsTextFieldWidget> createState() =>
      _EditGoalsTextFieldWidgetState();
}

class _EditGoalsTextFieldWidgetState extends State<EditGoalsTextFieldWidget> {
  // TextEditingController titleController = TextEditingController();
  // TextEditingController descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      // key: widget.formkey,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 5),
              child: Row(
                children: [
                  Text(
                    widget.step,
                    style: TextStyle(color: Colors.white),
                  ),
                  // Spacer(),
                  // IconButton(
                  //     onPressed: widget.ondelete,
                  //     icon: Icon(
                  //       Icons.delete,
                  //       color: Colors.white,
                  //     ))
                ],
              ),
            ),
            TextFormField(
              controller: widget.titleController,
              // initialValue: widget.titleControllertext,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Title",
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
            SizedBox(
              height: 8,
            ),
            TextFormField(
              controller: widget.descriptionController,
              // initialValue: widget.descriptionControllertext,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: "Description",
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
                  return 'Please enter The description';
                }
                return null;
              },
              style: TextStyle(color: Colors.white),
              maxLines: 4,
            ),
            SizedBox(
              height: 8,
            ),
            TextFormField(
              controller: widget.dateController,
              // initialValue: widget.dateControllertext,
              keyboardType: TextInputType.datetime,
              decoration: InputDecoration(
                labelText: "Target Date",
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
                  return 'Please fill The date';
                }
                return null;
              },
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    barrierColor: Color.fromARGB(255, 169, 249, 172),
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
                    widget.dateController.text =
                        formattedDate; //set output date to TextField value.
                  });
                } else {}
              },
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

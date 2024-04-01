import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GoalsTextFieldWidget extends StatefulWidget {
  final TextEditingController titleController;
  final TextEditingController descriptionController;
  final TextEditingController dateController;
  final String step;
  final GlobalKey formkey;
  const GoalsTextFieldWidget({
    super.key,
    required this.titleController,
    required this.descriptionController,
    required this.dateController,
    required this.step,
    required this.formkey,
  });
  @override
  State<GoalsTextFieldWidget> createState() => _GoalsTextFieldWidgetState();
}

class _GoalsTextFieldWidgetState extends State<GoalsTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formkey,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text(
                widget.step,
                style: const TextStyle(color: Colors.white),
              ),
            ),
            TextFormField(
              controller: widget.titleController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
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
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(
              height: 8,
            ),
            TextFormField(
              controller: widget.descriptionController,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
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
              style: const TextStyle(color: Colors.white),
              maxLines: 4,
            ),
            const SizedBox(
              height: 8,
            ),
            TextFormField(
              controller: widget.dateController,
              keyboardType: TextInputType.datetime,
              decoration: const InputDecoration(
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
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    barrierColor:  const Color.fromARGB(255, 38, 36, 36),
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1950),
                    lastDate: DateTime(2100));

                if (pickedDate != null) {
                  String formattedDate =
                      DateFormat('yyyy-MM-dd').format(pickedDate);
                  setState(() {
                    widget.dateController.text =
                        formattedDate; //set output date to TextField value.
                  });
                } else {}
              },
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:life_leaf/controller/reminder_db_functions/reminder_db_functions.dart';
import 'package:life_leaf/model/reminder_model/reminder_model.dart';
import 'package:life_leaf/view/screens/reminder_screen/local_notification.dart';

class AddReminder extends StatefulWidget {
  const AddReminder({super.key});

  @override
  State<AddReminder> createState() => _AddReminderState();
}

class _AddReminderState extends State<AddReminder> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _title = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _date = TextEditingController();
  DateTime selectedDate = DateTime.now();
  DateTime fullDate = DateTime.now();

  // Future<void> _selectTime(TextEditingController controller) async {
  //   final TimeOfDay? pickedTime = await showTimePicker(
  //     context: context,
  //     initialTime: TimeOfDay.now(),
  //   );

  //   if (pickedTime != null) {
  //     // ignore: use_build_context_synchronously
  //     final formattedTime = pickedTime.format(context);
  //     controller.text = formattedTime;
  //   }
  // }
  Future<DateTime> _selectDate(BuildContext context) async {
    final date = await showDatePicker(
        context: context,
        firstDate: DateTime(1900),
        initialDate: selectedDate,
        lastDate: DateTime(2100));
    if (date != null) {
      // ignore: use_build_context_synchronously
      final time = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.fromDateTime(selectedDate),
          initialEntryMode: TimePickerEntryMode.input);
      if (time != null) {
        setState(() {
          fullDate = DateTimeField.combine(date, time);
        });
        //schedule a notification
      }
      return DateTimeField.combine(date, time);
    } else {
      return selectedDate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 38, 36, 36),
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: const Text(
          'Add Reminder',
          style: TextStyle(
              color: Color.fromARGB(255, 145, 233, 151),
              fontFamily: 'Times',
              fontSize: 20,
              fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: TextFormField(
                  cursorColor: Colors.white,
                  controller: _title,
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter The title';
                    }
                    return null;
                  },
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: TextFormField(
                  cursorColor: Colors.white,
                  controller: _description,
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
                  maxLines: 3,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                child: TextFormField(
                  cursorColor: Colors.white,
                  controller: _date,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    labelText: "Date",
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
                    setState(() async {
                      DateTime selectDate = await _selectDate(context);
                      String formattedDate = DateFormat('dd-MM-yyyy - HH-mm-ss')
                          .format(selectDate);
                      _date.text = formattedDate;
                    });
                  },
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 70,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 180),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor:
                          const Color.fromARGB(255, 127, 128, 127)),
                  onPressed: () async {
                    // Trim the text to remove leading and trailing whitespaces
                    String title = _title.text.trim();
                    String description = _description.text.trim();
                    String date = _date.text.trim();

                    // Check if title is empty
                    if (title.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Title cannot be empty",
                            style: TextStyle(color: Colors.white)),
                        backgroundColor: Colors.red,
                      ));
                      return;
                    }

                    // Check if description is empty
                    if (description.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Description cannot be empty",
                            style: TextStyle(color: Colors.white)),
                        backgroundColor: Colors.red,
                      ));
                      return;
                    }

                    // Check if date is empty or not in the correct format
                    if (date.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text(
                            "Date cannot be empty ",
                            style: TextStyle(color: Colors.white)),
                        backgroundColor: Colors.red,
                      ));
                      return;
                    }

                    ReminderModel remainder = ReminderModel(
                        title: title, description: description, date: date);
                    ReminderDb.addReminder(remainder);
                    ReminderDb.getReminder();
                    var fullDate = date;
                    var thisDate = fullDate.split('-');
                    var data = thisDate.first.trim();
                    var year = thisDate.elementAt(2).trim();
                    var mnth = thisDate.elementAt(1).trim();
                    var hour = thisDate.elementAt(3).trim();
                    var min = thisDate.elementAt(4).trim();
                    var sec = thisDate.last.trim();
                    Notify.scheduleNewNotification(
                        data, mnth, year, hour, min, sec, title);
                    Navigator.pop(context);
                  },

                  // onPressed: () async {
                  //   ReminderModel remainder = ReminderModel(
                  //       title: _title.text,
                  //       description: _description.text,
                  //       date: _date.text);
                  //   ReminderDb.addReminder(remainder);
                  //   ReminderDb.getReminder();
                  //   var fullDate = _date.text;
                  //   var thisDate = fullDate.split('-');
                  //   var data = thisDate.first.trim();
                  //   var year = thisDate.elementAt(2).trim();
                  //   var mnth = thisDate.elementAt(1).trim();
                  //   var hour = thisDate.elementAt(3).trim();
                  //   var min = thisDate.elementAt(4).trim();
                  //   var sec = thisDate.last.trim();
                  //   Notify.scheduleNewNotification(
                  //       data, mnth, year, hour, min, sec, _title.text);
                  //   Navigator.pop(context);
                  // },
                  child: const Text(
                    'Save',
                    style: TextStyle(
                      color: Color.fromARGB(255, 169, 249, 172),
                      fontWeight: FontWeight.bold,
                      fontSize: 19,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

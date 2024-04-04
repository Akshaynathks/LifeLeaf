import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:life_leaf/controller/habit_db_functions/habit_db_functions.dart';
import 'package:life_leaf/view/widgets/scaffold_messenger.dart';
import 'package:streak_calendar/streak_calendar.dart';

class HabitOpen extends StatefulWidget {
  final String title;
  final List<String> maxcompleate;
  final String maxskipped;
  final String hkey;
  const HabitOpen({
    super.key,
    required this.title,
    required this.maxcompleate,
    required this.maxskipped,
    required this.hkey,
  });

  @override
  State<HabitOpen> createState() => _HabitOpenState();
}

class _HabitOpenState extends State<HabitOpen> {
  List<String> initialdatelist = [];

  @override
  void initState() {
    super.initState();
    initialdatelist.add(widget.maxskipped);
  }

  @override
  Widget build(BuildContext context) {
    List<String> dateStrings = widget.maxcompleate;
    List<DateTime> dates = dateStrings.map((dateString) {
      return DateFormat("yyyy/MM/dd").parse(dateString);
    }).toList();
    List<String> datesnew = widget.maxcompleate;
    datesnew = datesnew.toSet().toList();

    String initialDateString = widget.maxskipped;

    // Parse the initial date string into a DateTime object
    DateTime initialDate = DateFormat('yyyy/MM/dd').parse(initialDateString);

    // Get the current date
    DateTime currentDate = DateTime.now();

    // Calculate the difference in days
    int differenceInDays = currentDate.difference(initialDate).inDays;

    List<DateTime> initialDateTimeList = initialdatelist.map((dateString) {
      return DateFormat("yyyy/MM/dd").parse(dateString);
    }).toList();

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
          'Habit Journey',
          style: TextStyle(
              color: Color.fromARGB(255, 227, 251, 92),
              fontFamily: 'Times',
              fontSize: 25,
              fontWeight: FontWeight.w500),
        ),
        actions: [
          PopupMenuButton(
            iconColor: Colors.white,
            iconSize: 30,
            itemBuilder: (context) => [
              PopupMenuItem(
                child: const ListTile(
                  leading: Icon(Icons.delete),
                  title: Text('Delete'),
                ),
                onTap: () async {
                  bool confirmed = await showDeleteConfirmation(context);
                  if (confirmed) {
                    HabitDb.deleteHabit(widget.hkey);
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          SizedBox(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Container(
                color: const Color.fromARGB(255, 255, 255, 255),
                child: CleanCalendar(
                  selectedDates: initialDateTimeList,
                  selectedDatesProperties: DatesProperties(
                      hide: false,
                      disable: false,
                      datesDecoration:
                          DatesDecoration(datesBackgroundColor: Colors.blue)),
                  streakDatesProperties: DatesProperties(
                      hide: false,
                      disable: false,
                      datesDecoration: DatesDecoration(
                          datesBackgroundColor:
                              const Color.fromARGB(255, 149, 240, 152),
                          datesBorderColor:
                              const Color.fromARGB(255, 255, 0, 0))),
                  datesForStreaks: dates,
                  leadingTrailingDatesProperties:
                      DatesProperties(disable: true, hide: true),
                  headerProperties: HeaderProperties(
                    monthYearDecoration: MonthYearDecoration(
                      monthYearTextColor: Colors.black,
                      monthYearTextStyle:
                          Theme.of(context).textTheme.titleMedium,
                    ),
                    navigatorDecoration: NavigatorDecoration(
                      navigatorResetButtonIcon: const Icon(
                        Icons.restart_alt,
                        color: Colors.black,
                      ),
                      navigateLeftButtonIcon: const Icon(
                        Icons.arrow_circle_left,
                        color: Colors.black,
                      ),
                      navigateRightButtonIcon: const Icon(
                        Icons.arrow_circle_right,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  weekdaysProperties: WeekdaysProperties(
                    generalWeekdaysDecoration: WeekdaysDecoration(
                        weekdayTextColor: const Color.fromARGB(255, 0, 0, 0)),
                    sundayDecoration: WeekdaysDecoration(
                      weekdayTextColor: const Color.fromARGB(255, 0, 0, 0),
                    ),
                    saturdayDecoration: WeekdaysDecoration(
                      weekdayTextColor: const Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 80,
                height: 30,
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.blue,
                  child: const Text(
                    'Started On',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Times',
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 80,
                height: 30,
                child: Container(
                  alignment: Alignment.center,
                  color: Colors.green,
                  child: const Text(
                    'Completed',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'Times',
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 84, 84, 84)),
                height: 70,
                width: 300,
                child: Text(
                  widget.title,
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Times'),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 84, 84, 84)),
                height: 200,
                width: 320,
                child: Row(children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Max',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Times',
                              color: Colors.white),
                        ),
                        const Text(
                          'Completion Streak',
                          style: TextStyle(
                              color: Color.fromARGB(255, 185, 185, 185)),
                        ),
                        Text(
                          datesnew.length.toString(),
                          style: const TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Colors.green),
                        ),
                        const Text(
                          'days',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: VerticalDivider(
                      thickness: 2,
                      color: Color.fromARGB(255, 255, 255, 255),
                      width: 30,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Max',
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Times',
                              color: Colors.white),
                        ),
                        const Text(
                          'Skipped Days',
                          style: TextStyle(
                              color: Color.fromARGB(255, 185, 185, 185)),
                        ),
                        Text(
                          '${differenceInDays - datesnew.length == -1 ? 0 : differenceInDays - datesnew.length + 1}',
                          style: const TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 247, 177, 73)),
                        ),
                        const Text(
                          'days',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ]),
              ),
            ],
          ),
          // Container(
          //   width: 300,
          //   height: 200,
          //   decoration: BoxDecoration(
          //     border: Border.all(color: Colors.black),
          //   ),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Column(
          //         children: [
          //           Container(
          //             height: ,
          //             color: Colors.blue,
          //             child: Center(
          //               child: Text(
          //                 'Top Container',
          //                 style: TextStyle(color: Colors.white),
          //               ),
          //             ),
          //           ),
          //         ],
          //       ),
          //       VerticalDivider(
          //         thickness: 2,
          //         color: const Color.fromARGB(255, 255, 255, 255),
          //         width: 20,
          //       ),
          //       Container(
          //         height: 100,
          //         color: Colors.green,
          //         child: Center(
          //           child: Text(
          //             'Bottom Container',
          //             style: TextStyle(color: Colors.white),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // )
        ]),
      ),
    );
  }
}

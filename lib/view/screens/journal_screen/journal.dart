import 'package:flutter/material.dart';
import 'package:life_leaf/controller/journal_db_functions/journals_db_functions.dart';
import 'package:life_leaf/model/journal_model/journal_model.dart';
import 'package:life_leaf/view/screens/journal_screen/widgets/journal_card_widget.dart';

class Journal extends StatefulWidget {
  const Journal({super.key});

  @override
  State<Journal> createState() => _JournalState();
}

class _JournalState extends State<Journal> {
  late List<JournalModel> allJournals = journalsNotifier.value;
  late List<JournalModel> filteredJournals = [];

  void initState() {
    super.initState();
    JournalDb.getjournals();
  }

  void filterSearchResult(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredJournals = allJournals;
        journalsNotifier.value = filteredJournals;
      });
    } else {
      setState(() {
        filteredJournals = allJournals
            .where((element) => element.journalTitle!
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList();
        journalsNotifier.value = filteredJournals;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 62, 62, 62),
      body: Stack(
        children: [
          ValueListenableBuilder<List<JournalModel>>(
            valueListenable: journalsNotifier,
            builder: (context, value, child) {
              return value.isNotEmpty
                  ? GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 18.0,
                        crossAxisSpacing: 8.0,
                      ),
                      itemCount: value
                          .length, // Adjust this based on your actual item count
                      itemBuilder: (context, index) {
                        return JournalCardWidget(
                          title: value[index].journalTitle ?? '',
                          notes: value[index].journalNotes,
                          date: value[index].journalDate ?? '',
                          jkey: value[index].journalkey ?? '',
                           images: value[index].images,
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
                            'No Journals',
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: 'Times',
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 113, 191, 117)),
                          ),
                          SizedBox(
                            width: 200,
                            child: Text(
                              'Create Your notes and it will show up here',
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
                Navigator.pushNamed(context, 'addJournal');
              },
              child: Icon(Icons.add),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50)),
            ),
          ),
          // CustomSearchBar(onSearch: (query) {
          //   // Handle search query
          // }),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:life_leaf/controller/journal_db_functions/journals_db_functions.dart';
import 'package:life_leaf/model/journal_model/journal_model.dart';
import 'package:life_leaf/view/screens/journal_screen/widgets/journal_card_widget.dart';
import 'package:life_leaf/view/widgets/search.dart';

class Journal extends StatefulWidget {
  const Journal({super.key});

  @override
  State<Journal> createState() => _JournalState();
}

class _JournalState extends State<Journal> {

  bool _isSearchBarVisible = false;
late Box<JournalModel> journalBox;
  List<JournalModel> searchList = [];
  List<JournalModel> allJournal = [];

  @override
  void initState() {
    super.initState();
    JournalDb.getjournals();
    journalBox = Hive.box<JournalModel>("journal_details");
    allJournal = journalBox.values.toList();
  }
TextEditingController searchController=TextEditingController();
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
                  }, searchController: searchController,
              ),
            ),
              Expanded(
                child: ValueListenableBuilder<List<JournalModel>>(
                  valueListenable: journalsNotifier,
                  builder: (context, value, child) {
                    return searchController.text == ''
                        ? GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
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
                        :searchController.text != ''? 
                        GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 18.0,
                              crossAxisSpacing: 8.0,
                            ),
                            itemCount: searchList
                                .length, // Adjust this based on your actual item count
                            itemBuilder: (context, index) {
                              return JournalCardWidget(
                                title: searchList[index].journalTitle ?? '',
                                notes: searchList[index].journalNotes,
                                date: searchList[index].journalDate ?? '',
                                jkey: searchList[index].journalkey ?? '',
                                images: searchList[index].images,
                              ); // You can modify this to display data based on the index
                            },
                          ):const Center(
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
                Navigator.pushNamed(context, 'addJournal');
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
                              Color.fromRGBO(0, 0, 0, 1)),
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
   searchRemainder(String value)async{
setState(() {
  searchList=allJournal.where((element) => element.journalTitle!.toLowerCase().startsWith(value.toLowerCase())).toList();
}); }

}

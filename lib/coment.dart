// icon: Icon(Icons.menu),
//                 onPressed: () async {
//                   showDialog(
//                       context: context,
//                       builder: (context) {
//                         return AlertDialog(
//                           title: const Text('Log out'),
//                           content:
//                               const Text('Are you sure you want to log out?'),
//                           actions: [
//                             TextButton(
//                                 onPressed: () {
//                                   Navigator.pop(context);
//                                 },
//                                 child: const Text("Cancel")),
//                             TextButton(
//                                 onPressed: () async {
//                                   Navigator.pop(context);
//                                   final sharedpref =
//                                       await SharedPreferences.getInstance();
//                                   await sharedpref.remove('userEntered');
//                                   final shredpre =
//                                       await SharedPreferences.getInstance();
//                                   await shredpre.remove('userEnteredId');
//                                   // ignore: use_build_context_synchronously
//                                   Navigator.pushAndRemoveUntil(
//                                       context,
//                                       MaterialPageRoute(
//                                         builder: (context) => const Signin(),
//                                       ),
//                                       (route) => false);
//                                 },
//                                 child: const Text("Log out")),
//                           ],
//                         );
//                       });
//                 }
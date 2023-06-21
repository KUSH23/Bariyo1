import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mediafirst/main_screen.dart';
import 'package:mediafirst/constants.dart';
import 'package:mediafirst/controller/MenuAppController.dart';
import 'package:provider/provider.dart';

void main() async{
  runApp(MyApp());
}


// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: PostsPage(),
//       // home: const MyHomePage(title: 'OBS Handler'),
//     );
//   }
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Admin Panel',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
        canvasColor: secondaryColor,
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => MenuAppController(),
          ),
        ],
        child: MainScreen(),
      ),
    );
  }
}


// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//
//   List<TransactionModel> filteredFeedbackItems = [];
//
//   @override
//   void initState() {
//     super.initState();
//
//     FormController().getTransactionList(null).then((feedbackItems) {
//       setState(() {
//         filteredFeedbackItems = feedbackItems;
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: <Widget>[
//             Container(
//               margin: const EdgeInsets.all(10),
//               height: 50.0,
//               child: ElevatedButton(
//                 onPressed:() {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const CreateFeedback(),
//                       ));
//                 },
//                 child: const Text('Create'),
//               ),
//             ),
//             Container(
//               margin: const EdgeInsets.all(10),
//               height: 50.0,
//               child: ElevatedButton(
//                 onPressed:() {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => const FeedbackSearchPage(),
//                       ));
//                 },
//                 child: const Text('Inventory'),
//               ),
//             ),
//             Center(
//               child: filteredFeedbackItems.isNotEmpty
//                   ?Text("Recent ${filteredFeedbackItems.length} transactions!")
//                   : const CircularProgressIndicator(),
//             ),
//             const SizedBox(height: 5,),
//             Expanded(
//               child: filteredFeedbackItems.isNotEmpty
//                   ? ListView.builder(
//                 itemCount: filteredFeedbackItems.length,
//                 itemBuilder: (context, index) => Card(
//                   key: ValueKey(filteredFeedbackItems[index].uid),
//                   color: int.parse(filteredFeedbackItems[index].quantity!) > 0
//                       ? Colors.white : Colors.redAccent,
//                   elevation: 2,
//                   margin: const EdgeInsets.symmetric(vertical: 1),
//                   child: ListTile(
//                     leading: Text(
//                       filteredFeedbackItems[index].uid.toString(),
//                       style: const TextStyle(fontSize: 24),
//                     ),
//                     title: Text("${filteredFeedbackItems[index].itemname}, "
//                         "qty: ${filteredFeedbackItems[index].quantity}"),
//                     subtitle: Text(
//                         '${filteredFeedbackItems[index].comments}'),
//                   ),
//                 ),
//               )
//                   : const Text("Loading..."),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:mediafirst/Screens/feedback_details.dart';

import '../controller/form_controller.dart';
import '../models/form.dart';

class FeedbackListPage extends StatefulWidget {
  const FeedbackListPage({ Key? key, required this.feedbackForm}) : super(key: key);

  final FeedbackForm feedbackForm;

  @override
  State<FeedbackListPage> createState() => _FeedbackListPageState();
}

class _FeedbackListPageState extends State<FeedbackListPage> {
  TextEditingController editingController = TextEditingController();

  List<FeedbackForm> feedbackItems = [];
  List<FeedbackForm> filteredFeedbackItems = [];
  // Method to Submit Feedback and save it in Google Sheets

  @override
  void initState() {
    super.initState();

    FormController().getFeedbackList(widget.feedbackForm.description.toString()).then((feedbackItems) {
      setState(() {
        this.feedbackItems = feedbackItems;
        filteredFeedbackItems = feedbackItems;
      });
    });
  }

  void filterSearchResults(String query) {
    setState(() {
      filteredFeedbackItems = feedbackItems
          .where((item) => item.itemname!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data List"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            const SizedBox(height: 5,),
            TextFormField(
              onChanged: (value) {
                filterSearchResults(value);
              },
              controller: editingController,
              decoration: const InputDecoration(
                  labelText: "Search",
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)))),
            ),
            const SizedBox(height: 5,),
            Center(
              child: filteredFeedbackItems.isNotEmpty
                  ?Text("${filteredFeedbackItems.length} results found!")
              : const CircularProgressIndicator(),
            ),
            const SizedBox(height: 5,),
            Expanded(
              child: filteredFeedbackItems.isNotEmpty
                  ? ListView.builder(
                itemCount: filteredFeedbackItems.length,
                itemBuilder: (context, index) => Card(
                  key: ValueKey(filteredFeedbackItems[index].uid),
                  color: Colors.white,
                  elevation: 2,
                  margin: const EdgeInsets.symmetric(vertical: 1),
                  child: ListTile(
                    leading: Text(
                      filteredFeedbackItems[index].uid.toString(),
                      style: const TextStyle(fontSize: 24),
                    ),
                    title: Text("${filteredFeedbackItems[index].itemname}"),
                    subtitle: Text(
                        '${filteredFeedbackItems[index].description}'),
                    onTap: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsListPage(feedbackForm: filteredFeedbackItems[index]),
                          ));
                    },
                  ),
                ),
              )
                  : const Text("Loading..."),
            ),
          ],
        ),
      ),
    );
  }
}
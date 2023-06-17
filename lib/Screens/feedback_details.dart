import 'package:flutter/material.dart';
import 'package:mediafirst/models/form.dart';

class DetailsListPage extends StatelessWidget {
  const DetailsListPage({super.key, required this.feedbackForm});

  final FeedbackForm feedbackForm;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Details"),
      ),
        body: Center(
            child: Column(
              children: [
                SizedBox(height: 10,),
                Text(feedbackForm.itemname.toString()),
                SizedBox(height: 5,),
                Text(feedbackForm.quantity.toString()),
                SizedBox(height: 5,),
                Text(feedbackForm.project.toString()),
                SizedBox(height: 5,),
                ElevatedButton(
                    onPressed: (){},
                    child: Text("Create Transaction")
                ),
                SizedBox(height: 5,),
                ElevatedButton(
                    onPressed: (){},
                    child: Text("Upadte fields")
                ),
              ],
            ),
          ),
      floatingActionButton: FloatingActionButton(
        onPressed:() {
          Navigator.pop(context);
        },
        child: const Icon(
          Icons.house,
          color: Colors.white,
        ),
      ),
    );
  }
}

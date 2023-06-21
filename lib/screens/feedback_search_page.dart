

import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:mediafirst/Screens/feedback_list.dart';
import 'package:mediafirst/controller/form_controller.dart';
import 'package:mediafirst/models/ProjectModel.dart';
import 'package:mediafirst/models/form.dart';


class FeedbackSearchPage extends StatefulWidget {
  const FeedbackSearchPage({Key? key}) : super(key: key);

  @override
  State<FeedbackSearchPage> createState() => _FeedbackSearchPageState();
}

class _FeedbackSearchPageState extends State<FeedbackSearchPage> {
  List<ProjectModelForm> projectItems = [];
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  FeedbackForm feedbackForm = FeedbackForm();
  String dropdownValue = "Select";
  // TextField Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileNoController = TextEditingController();
  final TextEditingController feedbackController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _submitForm();
    nameController.addListener(_submitForm);
    emailController.addListener(_submitForm);
    FormController().getProjectsList(null).then((projectItems1) {
      setState(() {
        projectItems = projectItems1;
        dropdownValue = projectItems1[0].projectname.toString();
      });
    });

    // Timer.periodic(const Duration(seconds: 1), (timer) {
    //   print(projectItems.length);
    // });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    nameController.dispose();
    emailController.dispose();
    mobileNoController.dispose();
    feedbackController.dispose();
    super.dispose();
  }
  // Method to Submit Feedback and save it in Google Sheets
  void _submitForm() {
      // If the form is valid, proceed.
       feedbackForm = FeedbackForm(
          itemname: nameController.text,
          description: emailController.text,
          quantity: mobileNoController.text,
          discipline: feedbackController.text
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Search page"),
      ),
      backgroundColor: GFColors.WHITE,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Form(
                key: _formKey,
                child:
                Padding(padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      projectItems.isNotEmpty
                          ?DropdownButton<String>(
                            value: dropdownValue,
                            icon: const Icon(Icons.arrow_downward),
                            elevation: 16,
                            style: const TextStyle(color: Colors.deepPurple),
                            underline: Container(
                              height: 2,
                              color: Colors.deepPurpleAccent,
                            ),
                            onChanged: (String? value) {
                              // This is called when the user selects an item.
                              setState(() {
                                emailController.text = value!;
                                dropdownValue = value!;
                              });
                            },
                            items: projectItems.map<DropdownMenuItem<String>>((ProjectModelForm value) {
                              return DropdownMenuItem<String>(
                                value: value.projectname,
                                child: Text(value.projectname as String),
                              );
                            }).toList(),
                          )
                          : const Text("Project"),
                      TextFormField(
                        controller: nameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Valid Name';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            labelText: 'Project'
                        ),
                      ),
                    ],
                  ),
                )
            ),
            Container(
                margin: const EdgeInsets.all(10),
                height: 50.0,
                child: Center(
                  child: ElevatedButton(
                    onPressed:() {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FeedbackListPage(feedbackForm: feedbackForm),
                          ));
                    },
                    child: const Text('Get List'),
                  ),
                )
            ),
          ],
        ),
      )
    );
  }
}
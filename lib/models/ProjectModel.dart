/// FeedbackForm is a data class which stores data fields of Feedback.
class ProjectModelForm {
  String? uid;
  String? projectname;

  ProjectModelForm({this.uid, this.projectname});

  factory ProjectModelForm.fromMap(json) => ProjectModelForm(
    uid: json['uid'].toString(),
    projectname: json['projectname'].toString(),
  );



}
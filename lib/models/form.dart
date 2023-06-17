/// FeedbackForm is a data class which stores data fields of Feedback.
class FeedbackForm {
  String? uid;
  String? itemname;
  String? description;
  String? quantity;
  String? discipline;
  String? equipment;
  String? project;
  String? store;
  String? timestamp;

  FeedbackForm({this.uid, this.itemname, this.description, this.quantity,
    this.discipline, this.equipment, this.project, this.store, this.timestamp});

  factory FeedbackForm.fromMap(json) => FeedbackForm(
    uid: json['uid'].toString(),
    itemname: json['itemname'].toString(),
    description: json['oem'].toString(),
    quantity: json['quantity'].toString(),
    discipline: json['discipline'].toString(),
    equipment: json['equipment'].toString(),
    project: json['project'].toString(),
    store: json['store'].toString(),
    timestamp: json['timestamp'],
  );

}


class ProductDataModel {
  final num uid;
  final String itemname;
  final String oem;
  final num quantity;
  final String discipline;
  final String equipment;
  final String project;
  final String store;
  // final String timestamp;
  final DateTime timestamp;

  ProductDataModel({required this.uid, required this.itemname, required this.oem, required this.quantity, required this.discipline, required this.equipment, required this.project, required this.store, required this.timestamp});

  factory ProductDataModel.fromJson(Map<dynamic, dynamic> json) => ProductDataModel(
    uid: json["uid"],
    itemname: json["itemname"],
    quantity: json["quantity"],
    oem: json["oem"],
    equipment: json["equipment"],
    discipline: json["discipline"],
    project: json["project"],
    store: json["store"],
    // timestamp: json["timestamp"],
    timestamp: DateTime.parse(json["timestamp"]),
  );

  Map<String, dynamic> toJson() => {
    "uid": uid,
    "itemname": itemname,
    "quantity": quantity,
    "oem": oem,
    "equipment": equipment,
    "discipline": discipline,
    "project": project,
    "store": store,
    // "timestamp": timestamp,
    "timestamp": timestamp.toIso8601String(),
  };
}

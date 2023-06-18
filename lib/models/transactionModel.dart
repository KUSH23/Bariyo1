class TransactionModel {
  String? uid;
  String? itemname;
  String? comments;
  String? quantity;
  String? discipline;
  String? fromLoc;
  String? toLoc;
  String? timestamp;

  TransactionModel({this.uid, this.itemname, this.comments, this.quantity,
    this.discipline, this.fromLoc, this.toLoc, this.timestamp});

  factory TransactionModel.fromMap(json) => TransactionModel(
    uid: json['uid'].toString(),
    itemname: json['itemname'].toString(),
    comments: json['comments'].toString(),
    quantity: json['quantity'].toString(),
    discipline: json['discipline'].toString(),
    fromLoc: json['fromLoc'].toString(),
    toLoc: json['toLoc'].toString(),
    timestamp: json['timestamp'],
  );

}

class ProductTransDataModel {
  final num uid;
  final String itemname;
  final String comments;
  final num quantity;
  final String fromLoc;
  final String toLoc;
  // final String timestamp;
  final DateTime timestamp;

  ProductTransDataModel({required this.uid, required this.itemname, required this.comments, required this.quantity, required this.fromLoc, required this.toLoc, required this.timestamp});

  factory ProductTransDataModel.fromJson(Map<dynamic, dynamic> json) => ProductTransDataModel(
    uid: json["tuid"],
    itemname: json["itemname"],
    quantity: json["quantitychange"],
    comments: json["comments"],
    fromLoc: json["fromloc"],
    toLoc: json["toloc"],
    // timestamp: json["timestamp"],
    timestamp: DateTime.parse(json["timestamp"]),
  );

  Map<String, dynamic> toJson() => {
    "uid": uid,
    "itemname": itemname,
    "quantity": quantity,
    "comments": comments,
    "fromLoc": fromLoc,
    "toLoc": toLoc,
    // "timestamp": timestamp,
    "timestamp": timestamp.toIso8601String(),
  };
}
import 'dart:convert' as convert;
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mediafirst/models/ProjectModel.dart';
import 'package:mediafirst/models/home_product.dart';
import 'package:mediafirst/models/transactionModel.dart';
import '../models/form.dart';

/// FormController is a class which does work of saving FeedbackForm in Google Sheets using
/// HTTP GET request on Google App Script Web URL and parses response and sends result callback.
class FormController {

  // Google App Script Web URL.
  static const String URL = "https://script.google.com/macros/s/AKfycbziP2EbT0yN7T6hCYhtcgw8Rh5wknmi1fhFS04SxZ0ZeS9_rEDkb-vdsaMe39yla-z1Kw/exec";

  // Success Status Message
  static const STATUS_SUCCESS = "SUCCESS";

  /// Async function which saves feedback, parses [feedbackForm] parameters
  /// and sends HTTP GET request on [URL]. On successful response, [callback] is called.
  void submitForm(FeedbackForm feedbackForm,
      void Function(String) callback) async {
    try {
      await http.post(Uri.parse("$URL?sheet=sheet1"),
          headers: {
            'Content-Type': 'application/json; charset=utf-8',
          },
          body: jsonEncode(feedbackForm))
          .then((response) async {
        if (response.statusCode == 302) {
          var url = response.headers['location'];
          await http.get(Uri.parse(url!)).then((response) {
            callback(convert.jsonDecode(response.body)['status']);
          });
        } else {
          callback(convert.jsonDecode(response.body)['status']);
        }
      });
    } catch (e) {
      print(e);
    }
  }

  Future<bool> addProducts({required ProductDataModel product}) async {
    var url = "$URL?sheet=sheet1";
    var client = http.Client();
    try{
      var response = await client.post(Uri.parse(url),
          headers: {
            "Content-Type": "application/json; charset=utf-8",
          },
          body: convert.jsonEncode(product));
      if (response.statusCode == 302) {
        var url = response.headers["location"];
        response = await http.get(Uri.parse(url!));
        (print(convert.jsonDecode(response.body)["status"] + "addProduct1"));

      } else {
        (print(convert.jsonDecode(response.body)["status"]+"addProduct2"));
      }

      if(convert.jsonDecode(response.body)["status"]=="SUCCESS"){
        return true;
      }
      // print(results);
    } catch(e) {
      print(e.toString());
      return false;
    }
    return false;
  }

  Future<bool> updateProduct({required ProductDataModel product}) async {
    var url = "$URL?sheet=sheet1&update=1";
    var client = http.Client();
    try{
      var response = await client.post(Uri.parse(url),
          // headers: {
          //   'Content-Type': 'application/json; charset=utf-8',
          // },
          body: convert.jsonEncode(product));
      if (response.statusCode == 302) {
        var url = response.headers["location"];
        response = await http.get(Uri.parse(url!));
        (print(convert.jsonDecode(response.body)["status"] + "addProduct1"));

      } else {
        (print(convert.jsonDecode(response.body)["status"]+"addProduct2"));
      }

      if(convert.jsonDecode(response.body)['status']=="SUCCESS"){
        return true;
      }
      // print(results);
    } catch(e) {
      print(e.toString());
      return false;
    }
    return false;
  }

  Future<bool> transactionProduct({required ProductTransDataModel product}) async {
    var url = "$URL?sheet=transactions";
    var client = http.Client();
    try{
      var response = await client.post(Uri.parse(url),
          // headers: {
          //   'Content-Type': 'application/json; charset=utf-8',
          // },
          body: convert.jsonEncode(product));
      if (response.statusCode == 302) {
        var url = response.headers["location"];
        response = await http.get(Uri.parse(url!));
        (print(convert.jsonDecode(response.body)["status"] + "addProduct1"));

      } else {
        (print(convert.jsonDecode(response.body)["status"]+"addProduct2"));
      }

      if(convert.jsonDecode(response.body)['status']=="SUCCESS"){
        return true;
      }
      // print(results);
    } catch(e) {
      print(e.toString());
      return false;
    }
    return false;
  }

  /// Async function which loads feedback from endpoint URL and returns List.
  Future<List<FeedbackForm>> getFeedbackList(String? myitemname) async {
    var url = "$URL?sheet=sheet1";
    if(myitemname != null){url = "$URL?sheet=sheet1&cat=$myitemname";}
    return await http.get(Uri.parse(url)).then((response) {
      final jsonbody = response.body;
      final jsonFeedback = jsonDecode(jsonbody);
      final results = jsonFeedback["data"] as List;
      return results.map((json) => FeedbackForm.fromMap(json)).toList();
    });
  }

  Future<List<ProjectModelForm>> getProjectsList(String? myitemname) async {
    var url = "$URL?sheet=projects";
    if(myitemname != null){url = "$URL?sheet=projects&cat=$myitemname";}
    return await http.get(Uri.parse(url)).then((response) {
      final jsonbody = response.body;
      final jsonFeedback = jsonDecode(jsonbody);
      final results = jsonFeedback["data"] as List;
      return results.map((json) => ProjectModelForm.fromMap(json)).toList();
    });
  }

  Future<List<ProductDataModel>> getProductsList(String? myitemname) async {
    var url = "$URL?sheet=sheet1";
    List<ProductDataModel> mydata=[];
    if(myitemname != null){url = "$URL?sheet=sheet1&cat=$myitemname";}

    var client = http.Client();
    try{
      var response = await client.get(Uri.parse(url));
      var decodedResponse = jsonDecode(response.body);
      final results = decodedResponse["data"] as List;
      // print(results);
      mydata = results.map((json) => ProductDataModel.fromJson(json)).toList();
    } catch(e) {
      print(e.toString());
    }
    return mydata;
  }

  Future<List<ProductTransDataModel>> getProductsTransList(String? myitemname) async {
    var url = "$URL?sheet=transactions";
    List<ProductTransDataModel> mydata=[];
    if(myitemname != null){url = "$URL?sheet=transactions&cat=$myitemname";}

    var client = http.Client();
    try{
      var response = await client.get(Uri.parse(url));
      var decodedResponse = jsonDecode(response.body);
      // print(decodedResponse);
      final results = decodedResponse["data"] as List;
      // print(results);
      mydata = results.map((json) => ProductTransDataModel.fromJson(json)).toList();
      // print(mydata);
    } catch(e) {
      print(e.toString());
    }
    return mydata;
  }

  Future<List<TransactionModel>> getTransactionList(String? myitemname) async {
    var url = "$URL?sheet=transactions";
    if(myitemname != null){url = "$URL?sheet=projects&cat=$myitemname";}
    return await http.get(Uri.parse(url)).then((response) {
      final jsonbody = response.body;
      final jsonFeedback = jsonDecode(jsonbody);
      final results = jsonFeedback["data"] as List;
      return results.map((json) => TransactionModel.fromMap(json)).toList();
    });
  }
}
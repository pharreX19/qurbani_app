import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:qurbani/globals/globals.dart';

class ApiService{
  static final ApiService _instance = ApiService._internal();

  static ApiService instance = ApiService();

  factory ApiService(){
    return _instance;
  }

  ApiService._internal();

  Map<String, dynamic> headers = {
    HttpHeaders.acceptHeader : 'application/json',
    HttpHeaders.contentTypeHeader : 'application/json'
  };


  Future<dynamic> createNewRequest(String url, Map<String, dynamic> body) async{
//    print(body);
    http.Response response = await http.post(Globals.BASE_URL + url, body: jsonEncode(body));
    return jsonDecode(response.body);
//     const method = 'POST';
//     Uri uri = Uri.parse(Globals.BASE_URL + url);
//     http.MultipartRequest request = new http.MultipartRequest(method, uri);
//     request.fields['amount_paid'] = body['amount_paid'].toString();
//     request.fields['quantity'] = body['quantity'].toString();
//     request.fields['name'] = body['name'];
//     request.fields['price'] = body['price'].toString();
//     request.fields['type'] = body['type'];
//     request.fields['date'] = body['date'];
//     File imageFile = File(body['receipt']);
//     List<int> imageBytes = await imageFile.readAsBytes();
//     request.fields['image'] = base64Encode(imageBytes);
//
//     request.headers[HttpHeaders.acceptHeader] = headers[HttpHeaders.acceptHeader];
//     request.headers[HttpHeaders.contentTypeHeader] = headers[HttpHeaders.contentTypeHeader];
//
//      print(base64Encode(imageBytes));
//     http.StreamedResponse response = await request.send();
//     return http.Response.fromStream(response);
  }

  Future<dynamic> getAllNames(String url) async{
    http.Response response = await http.get(Globals.BASE_URL + url);
    return (jsonDecode(response.body)['results']);
  }

  Future<dynamic> updateName(String url,  Map<String, dynamic> body) async{
    http.Response response = await http.patch(Globals.BASE_URL + url, body: jsonEncode(body));
    return jsonDecode(response.body);
  }

  Future<dynamic> createName(String url,  Map<String, dynamic> body) async{
    http.Response response = await http.post(Globals.BASE_URL + url, body: jsonEncode(body));
    return jsonDecode(response.body);
  }

  Future<dynamic> deleteName(String url) async{
    http.Response response = await http.delete(Globals.BASE_URL + url);
    return jsonDecode(response.body);
  }

  Future<dynamic> fetchAllServices(String url) async{
    http.Response response = await http.get(Globals.BASE_URL + url);
    return (jsonDecode(response.body))['results'];
  }

  Future<dynamic> fetchAllServiceTypes(String url) async{
    http.Response response = await http.get(Globals.BASE_URL + url);
    return (jsonDecode(response.body))['results'];
  }

  Future<dynamic> updateServiceType(String url, Map<dynamic, dynamic> body) async{
    http.Response response = await http.patch(Globals.BASE_URL + url, body: jsonEncode(body));
    return (jsonDecode(response.body))['results'];
  }

  Future<dynamic> fetchAllRequests(String url) async{
    http.Response response = await http.get(Globals.BASE_URL + url);
    return (jsonDecode(response.body))['results'];
  }

  Future<dynamic> updateRequest(String url, Map<String, dynamic> body) async{
    http.Response response = await http.patch(Globals.BASE_URL + url, body: jsonEncode(body));
    return (jsonDecode(response.body))['results'];
  }

  Future<dynamic> fetchAllInformation(String url) async{
    http.Response response = await http.get(Globals.BASE_URL + url);
    return (jsonDecode(response.body))['results'];
  }

  Future<dynamic> fetchAllFeedback(String url) async{
    http.Response response = await http.get(Globals.BASE_URL + url);
    return (jsonDecode(response.body))['results'];
  }

  Future<dynamic> createFeedback(String url, Map<String, dynamic> body) async{
    http.Response response = await http.post(Globals.BASE_URL + url, body: jsonEncode(body));
    return (jsonDecode(response.body))['results'];
  }

  Future<dynamic> fetchFeedback(String url, Map<String, dynamic> body) async{
    http.Response response = await http.get(Globals.BASE_URL + url);
    return (jsonDecode(response.body))['results'];
  }

  Future<dynamic> updateFeedback(String url, Map<String, dynamic> body) async{
    http.Response response = await http.patch(Globals.BASE_URL + url, body: jsonEncode(body));
    return (jsonDecode(response.body))['results'];
  }
}
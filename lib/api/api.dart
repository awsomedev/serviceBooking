import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:qask/api/userService.dart';
import 'package:qask/constants/itemModels.dart';
import 'package:qask/complaintModel.dart';

class Status {
  String msg;
  bool status;
  Status({this.msg, this.status});
}

class Api {
  Uri getUri(String s) {
    return Uri.parse('http://mywebtest.in/complaint/api/$s');
  }

  Future<Status> signUp(
      {String userName,
      String email,
      String password,
      String phone,
      String address,
      String city}) async {
    var body = jsonEncode({
      "username": userName,
      "email": email,
      "password": password,
      "phone": phone,
      "address": address,
      "city": city,
    });

    print(body);

    var uri = getUri('api.php?action=register');
    print(uri);

    var response = await http.post(uri, body: body);
    try {
      var body = jsonDecode(response.body);
      if (body['status'] == 'true') {
        await UserService.setUserId(body['userid'].toString());
        return Status(msg: body['message'], status: body['status'] == 'true');
      } else {
        return Status(msg: body['message'], status: body['status'] == 'true');
      }
    } catch (e) {
      return Status(msg: 'Error occured', status: false);
    }
  }

  Future<Status> signIn({
    String userName,
    String password,
  }) async {
    var body = jsonEncode({
      "username": userName,
      // "email": email,
      "password": password,
    });

    var response = await http.post(getUri('api.php?action=login'), body: body);
    try {
      var body = jsonDecode(response.body);
      print(body);
      if (body['status'] == 'true') {
        await UserService.setUserId(body['userid'].toString());
        return Status(msg: body['message'], status: body['status'] == 'true');
      } else {
        return Status(msg: body['message'], status: body['status'] == 'true');
      }
    } catch (e) {
      return Status(msg: 'Error occured', status: false);
    }
  }

  Future<Status> forgotPassword({
    String email,
  }) async {
    var body = jsonEncode({
      "email": email,
    });

    var response = await http.post(getUri('api.php?action=forgot'), body: body);
    try {
      var body = jsonDecode(response.body);

      return Status(msg: body['message'], status: body['status'] == 'true');
    } catch (e) {
      return Status(msg: 'Error occured', status: false);
    }
  }
Future<ItemModel> getService() async {
    var userId = await UserService.getUserId();
    print('working');
    var response = await http.get(getUri('api.php?action=getIssues'),);
    try {
      print(response.body);
      return itemModelFromJson(response.body);
    } catch (e) {
      return ItemModel(issues: []);
    }
  }



  Future<ComplaintModel> getSolutions() async {
    var userId = await UserService.getUserId();
    print(userId);
    var body = jsonEncode({
      "user_id": userId,
    });

    var response =
        await http.post(getUri('api.php?action=getMySolution'), body: body);
    try {
      var body = jsonDecode(response.body);
      print(body);

      return complaintModelFromJson(response.body);
    } catch (e) {
      return ComplaintModel(
        complaints: [],
      );
    }
  }

  Future<Status> submitSolutions(
      {String service, String query, String location}) async {
    var userId = await UserService.getUserId();
    print(userId);
    var body = jsonEncode({
      "service": service,
      "user_id": userId,
      "query": query,
      "location": location,
    });

    var url = getUri('api.php?action=submit_complaint');
    print(body);

    var response = await http.post(url, body: body);
    try {
      print(response.body);
      var body = jsonDecode(response.body);
      print(body);

      return Status(msg: body['message'], status: body['status'] == 'true');
    } catch (e) {
      return Status(msg: 'Error occured', status: false);
    }
  }
}

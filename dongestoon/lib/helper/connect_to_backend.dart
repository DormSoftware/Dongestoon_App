import 'dart:convert';

import 'package:dongestoon/models/group.dart';
import 'package:http/http.dart' as http;

import '../models/user.dart';

class BackendConnection {
  var uri = "https://dongestoon.liara.run";

  static Future<http.Response> post(String url,String body) async {
    var result = await http.post(Uri.parse("https://dongestoon.liara.run/$url"));
    return result;
  }

  static Future<http.Response> get(String url,String body) async {
    var result = await http.post(Uri.parse("https://dongestoon.liara.run/$url"));
    return result;
  }
   Future<http.Response> register(User user) async {
    var result;
    Map<String, dynamic> postData = {
      "username": user.userName,
      "name": user.name,
      "lastName": user.lastName,
      "email": user.email,
      "password": user.password
      // Add other required fields as needed
    };
    try {
      String jsonData = jsonEncode(postData);
      result = await http.post(Uri.parse("$uri/Auth/Register"),
          headers: {
            'Content-Type': 'application/json',
            'Auther' : 'barea csdcsdcsdscsd'
          },
          body: jsonData);
    } catch (e) {
      print(e.toString());
    }
    return result;
  }

  Future<http.Response> login(String userName, String password) async {
    Map<String, dynamic> postData = {
      "userName": userName,
      "password": password,
    };
    String jsonData = jsonEncode(postData);
    var result = await http.post(Uri.parse("$uri/Auth/Login"),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonData);
    print(result.body);
    return result;
  }

  Future<http.Response> addGroup(Group group) async {
    Map<String, dynamic> postData = {
      "name": group.name,
      "users": group.userList,
    };
    String jsonData = jsonEncode(postData);
    var result = http.post(
      Uri.parse("$uri/Groups"),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonData,
    );
    return result;
  }
}

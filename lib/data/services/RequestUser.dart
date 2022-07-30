//https://desarolloweb2021a.000webhostapp.com/APIMOVIL/listaruser.php
import 'package:flutter/foundation.dart';
import 'package:flutter_login_ui/Donmain/Models/ResponseUser.dart';
import 'package:flutter_login_ui/Donmain/Models/User.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
class RequestUser {


  static Future<bool> registerUser(http.Client client, User user ) async {
    var url = Uri.parse(
        "https://desarolloweb2021a.000webhostapp.com/APIMOVIL/agregarUser.php");
    final response = await client.post(url, body: user.toJson());
    if (kDebugMode) {
      print(response.body.toString());
    }
    return compute(responseRegister, response.body);
  }

  static Future<List<User>> userValidate(
      http.Client client, String user, String pass) async {
    var url = Uri.parse(
        "https://desarolloweb2021a.000webhostapp.com/APIMOVIL/listaruser.php");

    final response = await client.post(url, body: {
      'user': user,
      'pass': pass,
    });
    if (kDebugMode) {
      print(response.body.toString());
    }
    return compute(parseToList, response.body);
  }

  static List<User> parseToList(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<User>((json) => User.mappingJson(json)).toList();
  }

  static bool responseRegister(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return !identical(parsed.map<ResponseUser>((json) => ResponseUser
        .mappingJson(json))
        .first!
        .message!
        .toLowerCase(), "no");
  }
}

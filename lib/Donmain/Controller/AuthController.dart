import 'package:flutter_login_ui/Donmain/Models/User.dart';
import 'package:flutter_login_ui/data/services/RequestUser.dart';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AuthController extends GetxController {
  final Rxn<List<User>> _users = Rxn<List<User>>();

  List<User>? get users => _users.value;

  Future<void> sendData(
      http.Client cliente, String user, String pass) async {
    _users.value = await RequestUser.userValidate(cliente, user, pass);
  }


  Future<bool> registerUser(
      http.Client client, User user) async {
      return await RequestUser.registerUser(client, user);
  }

}

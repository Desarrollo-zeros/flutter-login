import 'package:flutter/foundation.dart';

class User {
  final String id;
  final String name;
  final String rol;
  final String user;
  final String password;

  User(
      {required this.id,
      required this.name,
      required this.rol,
      required this.user,
      required this.password});

  Object toJson() => {
    'nombre': name,
    'user': user,
    'pass' : password,
    'rol' : "1",
    "id" : "0"
  };


  factory User.mappingJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['nombre'],
      rol: json['rol'],
      user: json['user'],
      password: ''
    );
  }

}

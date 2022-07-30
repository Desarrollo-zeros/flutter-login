import 'package:flutter/foundation.dart';
class ResponseUser{

  final String message;
  ResponseUser({required this.message});

  factory ResponseUser.mappingJson(Map<String, dynamic> json) {
    return ResponseUser(
      message: json['mensaje']
    );
  }

}
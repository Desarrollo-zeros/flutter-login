//https://desarolloweb2021a.000webhostapp.com/APIMOVIL/listaruser.php
import 'package:flutter/foundation.dart';
import 'package:flutter_login_ui/Donmain/Models/ResponseUser.dart';
import 'package:flutter_login_ui/Donmain/Models/User.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as fs;

import '../../Donmain/Models/Product.dart';
class RequestProduct {

  static final fs.FirebaseStorage storage = fs.FirebaseStorage.instance;
  static final FirebaseFirestore _db  = FirebaseFirestore.instance;



  static Future<void> create(Map<String, dynamic> product, file) async {
    var url = "";
    if(file != null){
      url = await uploadFile(file, product["Id"]);
    }
    product["File"] = url.toString();
    await _db.
            collection("Product").
            doc(product["Id"]).
            set(product).
            catchError((e){});
  }

  static Future<dynamic> uploadFile(var file, var id) async {
      final fs.Reference storageRefence = fs.FirebaseStorage.instance.ref().child("Id");
      fs.TaskSnapshot taskSnapshot = await storageRefence.child(id).putFile(file);
      var url  = await taskSnapshot.ref.getDownloadURL();
      return url.toString();
  }

  static Future<void> update(String id, Map<String, dynamic> product) async {
    await _db.collection('Product').doc(id).update(product).catchError((e){});
  }

  static Future<void> delete(String id, Map<String, dynamic> product) async {
    await _db.collection('Product').doc(id).delete().catchError((e){});
  }

  static Future<List<Product>> getAll() async{
     var  response = await _db.collection('Product').get();
     List<Product> products = [];
     for(var doc in response.docs){
       products.add(Product.sendDoc(doc.data()));
     }
     return products;
  }

}
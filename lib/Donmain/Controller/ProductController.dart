
import 'package:flutter_login_ui/Donmain/Models/Product.dart';
import 'package:flutter_login_ui/data/services/RequestProduct.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ProductController extends GetxController {
   final Rxn<List<Product>> _products = Rxn<List<Product>>();

  Future<void> getAll() async {
    _products.value = await RequestProduct.getAll();
  }

   Future<void> create(Map<String, dynamic> product, file) async {
      await RequestProduct.create(product, file);
   }

}

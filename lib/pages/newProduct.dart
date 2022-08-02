import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';

import '../Donmain/Models/Product.dart';

class NewProduct extends StatefulWidget {

  NewProduct();

  @override
  NewProductState createState() => NewProductState();
}

class NewProductState extends State<NewProduct> {
  NewProductState();

  List<Product> _cart =  <Product>[];

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Product'),
      ),
      body: ListView.builder(
          itemCount: _cart.length,
          itemBuilder: (context, index) {
            var item = _cart[index];
            return Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
              child: Card(
                elevation: 4.0,
                child: ListTile(
                  leading: CircleAvatar(
                      backgroundImage: NetworkImage(item.File)
                  ),
                  title: Text(item.Detailt),
                  trailing: GestureDetector(
                      child: Icon(
                        Icons.remove_circle,
                        color: Colors.red,
                      ),
                      onTap: () {
                        setState(() {
                          _cart.remove(item);
                        });
                      }),
                ),
              ),
            );
          }),
    );
  }
}
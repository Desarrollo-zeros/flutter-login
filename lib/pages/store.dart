import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_login_ui/Donmain/Models/Product.dart';
import 'package:flutter_login_ui/data/services/RequestProduct.dart';
import 'package:flutter_login_ui/pages/CreateProduct.dart';
import 'package:flutter_login_ui/pages/cart.dart';
import 'package:flutter_login_ui/pages/widgets/header_widget.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';



class StorePageState extends StatefulWidget {
  const StorePageState({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePageState> {
  List<Product> _dishes =  <Product>[];
  List<Product> _cartList = <Product>[];

  @override
  void initState() {
    super.initState();
    _populateDishes();
    Firebase.initializeApp().whenComplete(() {
      print("completed");
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: SpeedDial(
        icon: Icons.navigate_next,
        backgroundColor: Colors.purpleAccent  ,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.add),
            label: 'Add Product',
            backgroundColor: Colors.green,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CreateProduct()
                ),
              );

            },
          ),
          SpeedDialChild(
            label: 'Cart Product',
            child: Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                Icon(
                  Icons.shopping_cart,
                  size: 36.0,
                ),
                if (_cartList.length > 0)
                  Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: CircleAvatar(
                      radius: 8.0,
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      child: Text(
                        _cartList.length.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            onTap: () {
              if (_cartList.isNotEmpty)
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Cart(_cartList),
                  ),
                );
            },
          ),
        ]),
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16.0, top: 8.0),
            child: GestureDetector(
              child: Stack(
                alignment: Alignment.topCenter,
                children: <Widget>[
                  Icon(
                    Icons.shopping_cart,
                    size: 36.0,
                  ),
                  if (_cartList.length > 0)
                    Padding(
                      padding: const EdgeInsets.only(left: 2.0),
                      child: CircleAvatar(
                        radius: 8.0,
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        child: Text(
                          _cartList.length.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12.0,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              onTap: () {
                if (_cartList.isNotEmpty)
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Cart(_cartList),
                    ),
                  );
              },
            ),
          )
        ],
      ),
      body: _buildGridView(),
    );
  }

  

  GridView _buildGridView() {
    return GridView.builder(
        padding: const EdgeInsets.all(4.0),
        gridDelegate:
        SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: _dishes.length,
        itemBuilder: (context, index) {
          var item = _dishes[index];
          return Card(
              elevation: 4.0,
              child: Stack(
                fit: StackFit.loose,
                alignment: Alignment.center,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image(image: NetworkImage(item.File)),
                      Text(
                        item.Detailt,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.subtitle1,
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      right: 8.0,
                      bottom: 8.0,
                    ),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                        child: (!_cartList.contains(item))
                            ? Icon(
                          Icons.add_circle,
                          color: Colors.green,
                        )
                            : Icon(
                          Icons.remove_circle,
                          color: Colors.red,
                        ),
                        onTap: () {
                          setState(() {
                            if (!_cartList.contains(item))
                              _cartList.add(item);
                            else
                              _cartList.remove(item);
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ));
        });
  }

  void _populateDishes() async{

    var products = RequestProduct.getAll();
    var listProduct = await products;
    setState((){
      _dishes =  listProduct;
    });
  }
}
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_login_ui/pages/NewStore.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../Donmain/Controller/AuthController.dart';
import 'login_page.dart';

class SplashProduct extends StatefulWidget {
  SplashProduct({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  SplashProductState createState() => SplashProductState();
}

class SplashProductState extends State<SplashProduct> {
  bool _isVisible = false;

  SplashProductState(){
    Get.lazyPut(()=>AuthController());
    new Timer(const Duration(milliseconds: 2000), (){
      setState(() {
        Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => NewStoreStateWidget()), (route) => false);
      });
    });

    new Timer(
      Duration(milliseconds: 10),(){
        setState(() {
          _isVisible = true; // Now it is showing fade effect and navigating to Login page
        });
      }
    );

  }

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
          colors: [Theme.of(context).accentColor, Theme.of(context).primaryColor],
          begin: const FractionalOffset(0, 0),
          end: const FractionalOffset(1.0, 0.0),
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp,
        ),
      ),
      child: AnimatedOpacity(
        opacity: _isVisible ? 1.0 : 0,
        duration: Duration(milliseconds: 1200),
        child: Center(
          child: Container(
            height: 140.0,
            width: 140.0,
            child: Center(
              child: ClipOval(
                child: Icon(Icons.android_outlined, size: 128,), //put your logo here
              ),
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 2.0,
                  offset: Offset(5.0, 3.0),
                  spreadRadius: 2.0,
                )
              ]
            ),
          ),
        ),
      ),
    );
  }
}
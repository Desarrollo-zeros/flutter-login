
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_ui/Donmain/Controller/AuthController.dart';
import 'package:flutter_login_ui/common/theme_helper.dart';


import '../res/assets_res.dart';
import 'registration_page.dart';
import 'widgets/header_widget_src.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:material_dialogs/material_dialogs.dart';


class LoginPage extends StatefulWidget{
  const LoginPage({Key? key}): super(key:key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  double _headerHeight = 350;
  Key _formKey = GlobalKey<FormState>();
  var _iconLogo  = Image.asset(AssetsRes.ZEROWPNG);
  TextEditingController userName = TextEditingController(), password = TextEditingController();


  AuthController authController = Get.find();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: _headerHeight,
              child: HeaderWidget(_headerHeight, true, _iconLogo), //let's create a common header widget
            ),
            SafeArea(
              child: Container(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  margin: EdgeInsets.fromLTRB(20, 10, 20, 10),// This will be the login form
                child: Column(
                  children: [
                    Text(
                      'Welcome',
                      style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Test login Flutter Specialization',
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(height: 30.0),
                    Form(
                      key: _formKey,
                        child: Column(
                          children: [
                            Container(
                              child: TextField(
                                controller: userName,
                                decoration: ThemeHelper().textInputDecoration('User Name', 'Enter your user name'),
                              ),
                              decoration: ThemeHelper().inputBoxDecorationShaddow(),
                            ),
                            SizedBox(height: 30.0),
                            Container(
                              child: TextField(
                                controller: password,
                                obscureText: true,
                                decoration: ThemeHelper().textInputDecoration('Password', 'Enter your password'),
                              ),
                              decoration: ThemeHelper().inputBoxDecorationShaddow(),
                            ),
                            SizedBox(height: 15.0),
                            Container(
                              margin: EdgeInsets.fromLTRB(10,0,10,20),
                              alignment: Alignment.topRight,
                              child: GestureDetector(
                                onTap: () {
                                  //Navigator.push( context, MaterialPageRoute( builder: (context) => ), );
                                },
                                child: Text( "Forgot your password?", style: TextStyle( color: Colors.grey, ),
                                ),
                              ),
                            ),
                            Container(
                              decoration: ThemeHelper().buttonBoxDecoration(context),
                              child: ElevatedButton(
                                style: ThemeHelper().buttonStyle(),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                                  child: Text('Sign In'.toUpperCase(), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),),
                                ),
                                onPressed: (){
                                  //After successful login we will redirect to profile page. Let's create profile page now
                                  authController
                                      .sendData(http.Client(), userName.text,
                                      password.text)
                                      .then((_) {
                                    if (authController.users?.isNotEmpty == true) {
                                      //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProfilePage()));

                                      ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content:
                                            Text("Bienvenido....: ${authController.users?.first.name} ",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                                            ),
                                            duration: Duration(seconds: 2), backgroundColor: Colors.green,
                                          )
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content:
                                              Text("Error user y/o password incorrect",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                                            ),
                                            duration: Duration(seconds: 2), backgroundColor: Colors.red,
                                          )
                                      );
                                    }
                                  });
                                },
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.fromLTRB(10,20,10,20),
                              //child: Text('Don\'t have an account? Create'),
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(text: "Don\'t have an account? "),
                                    TextSpan(
                                      text: 'Create',
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = (){
                                          Get.toNamed('/Register');
                                        },
                                      style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).accentColor),
                                    ),
                                  ]
                                )
                              ),
                            ),
                          ],
                        )
                    ),
                  ],
                )
              ),
            ),
          ],
        ),
      ),
    );

  }
}
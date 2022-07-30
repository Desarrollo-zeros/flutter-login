import 'package:flutter/material.dart';
import 'package:flutter_login_ui/Donmain/Controller/AuthController.dart';
import 'package:flutter_login_ui/pages/registration_page.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import 'pages/splash_screen.dart';

void main() {
  runApp(LoginUiApp());
}

class LoginUiApp extends StatelessWidget {

  //Color _primaryColor = HexColor('#DC54FE');
  //Color _accentColor = HexColor('#8A02AE');

  // Design color
  // Color _primaryColor= HexColor('#FFC867');
  // Color _accentColor= HexColor('#FF3CBD');

  // Our Logo Color
   Color _primaryColor= HexColor('#D44CF6');
   Color _accentColor= HexColor('#5E18C8');
   String _title = "Dev Zeros Login";

  // Our Logo Blue Color
  //Color _primaryColor= HexColor('#651BD2');
  //Color _accentColor= HexColor('#320181');



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      title: _title,
      routes: {
        '/Register': (context) => RegistrationPage(),
        '/index' : (context) => SplashScreen(title: _title),
      },
      theme: ThemeData(
        primaryColor: _primaryColor,
        accentColor: _accentColor,
        scaffoldBackgroundColor: Colors.grey.shade100,
        primarySwatch: Colors.grey,
      ),
      home: SplashScreen(title: _title),
    );
  }
}



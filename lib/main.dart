import 'package:flutter/material.dart';
import 'package:flutter_login_ui/Donmain/Controller/AuthController.dart';
import 'package:flutter_login_ui/pages/NewStore.dart';
import 'package:flutter_login_ui/pages/registration_page.dart';
import 'package:flutter_login_ui/pages/store.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import 'pages/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
void main()  async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(LoginUiApp());
}

class LoginUiApp extends StatelessWidget {


  // Our Logo Color
   Color _primaryColor= HexColor('#D44CF6');
   Color _accentColor= HexColor('#5E18C8');
   String _title = "Dev Zeros Login";



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      title: _title,
      routes: {
        '/Register': (context) => RegistrationPage(),
        '/index' : (context) => SplashScreen(title: _title),
        '/store' : (context) => StorePageState(title: _title,),
        '/panel' : (context) => NewStoreStateWidget(),
      },
      theme: ThemeData(
        primaryColor: _primaryColor,
        accentColor: _accentColor,
        scaffoldBackgroundColor: Colors.grey.shade100,
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(title: _title),
    );
  }
}



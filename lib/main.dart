import 'package:flutter/material.dart';
import 'package:practica2/src/screens/intenciones_screen.dart';
import 'package:practica2/src/screens/login.dart';
import 'package:practica2/src/screens/propinas_page.dart';
import 'package:practica2/src/screens/splash_screen.dart';


void main() {
  runApp((MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/opc1' : (BuildContext context) => PropinaPage(),
        '/intenciones' : (BuildContext context) => IntencionesScreen(),
        
      },
      debugShowCheckedModeBanner: false,
      home: SplashScreenD(),
    );
  }
}
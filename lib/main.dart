import 'package:flutter/material.dart';
import 'package:practica2/src/screens/agregar_nota.dart';
import 'package:practica2/src/screens/intenciones_screen.dart';
import 'package:practica2/src/screens/movies_screen/popular_screen.dart';
import 'package:practica2/src/screens/notas_screen.dart';
import 'package:practica2/src/screens/profile_screen.dart';
import 'package:practica2/src/screens/propinas_page.dart';
import 'package:practica2/src/screens/splash_screen.dart';
import 'package:practica2/src/screens/tareas_screen/agregar_tarea.dart';
import 'package:practica2/src/screens/tareas_screen/tareas_screen.dart';


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
        '/notas' : (BuildContext context) => NotasScreen(),
        '/agregar' : (BuildContext context) => AgregarNotaScreen(),
        '/profile' : (BuildContext context) => ProfileScreen(),
        '/movie' : (BuildContext context) => PopupalScreen(),
        '/tareas' : (BuildContext context) => TareasScreen(),
        '/agregar_tareas' : (BuildContext context) => AgregarTareasScreen(),
        
      },
      debugShowCheckedModeBanner: false,
      home: SplashScreenD(),
    );
  }
}
import 'package:flutter/material.dart';

import 'package:practica2/src/screens/tareas_screen/tareas_actuales.dart';
import 'package:practica2/src/screens/tareas_screen/tareas_finalizadas.dart';

class TareasScreen extends StatefulWidget {
  TareasScreen({Key? key}) : super(key: key);

  @override
  _TareasScreenState createState() => _TareasScreenState();
}

class _TareasScreenState extends State<TareasScreen> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title:  Text('Tareas'),
          centerTitle: true,
          bottom: TabBar(
            tabs:[
              Tab(text: 'Nuevos', icon: Icon(Icons.assignment)),
              Tab(text: 'Finalizados', icon: Icon(Icons.assignment_turned_in))
            ],
          ) ,
        ),
        body: TabBarView(
          children: [
            TareasActuales(),
            TareasFinalizadas(),
          ]
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add, size: 32),
          onPressed: (){
             Navigator.pushNamed(context, '/agregar_tareas').whenComplete(
              (){ setState(() {            
                });
              }
            );
          }
        ),
      ),
    );
  }
}
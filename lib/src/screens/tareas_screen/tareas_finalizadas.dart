import 'package:flutter/material.dart';
import 'package:practica2/src/database/database_helper_tareas.dart';
import 'package:intl/intl.dart';
import 'package:practica2/src/models/tareas_model.dart';
class TareasFinalizadas extends StatefulWidget {
  const TareasFinalizadas({Key? key}) : super(key: key);

  @override
  _TareasFinalizadasState createState() => _TareasFinalizadasState();
}

class _TareasFinalizadasState extends State<TareasFinalizadas> {
 late DatabaseHelperTarea _databaseHelperTarea;
  late String now = DateFormat('yyyy-MM-dd').format(DateTime.now());
  late DateTime formatnow;
  late int act;
  late int id;

   @override
  void initState(){
    super.initState();
    _databaseHelperTarea = DatabaseHelperTarea();
  }

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      body: ListView(
        padding: EdgeInsets.all(10.0) ,
        children: [
          _cardTarea(),
        ],) ,
    );
    
  }

  Widget _cardTarea() {
      return FutureBuilder(
         future: _databaseHelperTarea.getTareasFinalizadas(),
         builder: (BuildContext , AsyncSnapshot<List<TareasModel>> snapshot){
          if(snapshot.hasError){
            return Center(child: Text("Ocurrio un error en la peticion"),);
          }else{
            if(snapshot.connectionState == ConnectionState.done){
              return _listadoTareas(snapshot.data!);
            }else{
              return Center(child:CircularProgressIndicator(),);
            }
          }
        },
      );
  }

  Widget _listadoTareas(List<TareasModel> tareas) {
    return ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount:tareas.length,
            itemBuilder:(BuildContext context, index){
              TareasModel tarea = tareas[index];
              return Card(
                elevation: 15.0, //bordees oscuros
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15), ), ), //esquinas redondas
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                          
                          width: 7.0 , color: DateTime.parse(tarea.fechaEntrega!).isBefore(DateTime.parse(now)) ? Colors.orange : Colors.green
                        )
                      )
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          leading: DateTime.parse(tarea.fechaEntrega!).isBefore(DateTime.parse(now)) ? Icon(Icons.assignment_turned_in, color: Colors.orange) : Icon(Icons.assignment_turned_in, color: Colors.green),
                          title: Text('#${tarea.idTarea} - ${tarea.nomTarea}', style: TextStyle( fontWeight: FontWeight.bold)),
                          subtitle: Text('${tarea.dscTarea}', style: TextStyle( color: Colors.black87)),
                        ),
                        
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          child: Text(DateTime.parse(tarea.fechaEntrega!).isBefore(DateTime.parse(now)) ? 'Fecha entrega: ${tarea.fechaEntrega} - Entregado con retardo' : 'Fecha entrega: ${tarea.fechaEntrega} - Entregado a tiempo', 
                                 style: TextStyle( color: Colors.black54) ,)
                          ),
                        
                      ],),
                    ),
                );
            }
          );
  }
}
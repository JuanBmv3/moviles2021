import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:practica2/src/database/database_helper_tareas.dart';
import 'package:practica2/src/models/tareas_model.dart';
import 'package:practica2/src/screens/tareas_screen/agregar_tarea.dart';

class TareasActuales extends StatefulWidget {
  const TareasActuales({Key? key}) : super(key: key);

  @override
  _TareasActualesState createState() => _TareasActualesState();
}

class _TareasActualesState extends State<TareasActuales> {
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
         future: _databaseHelperTarea.getTareasActuales(),
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
                          
                          width: 7.0 , color: DateTime.parse(tarea.fechaEntrega!).isBefore(DateTime.parse(now)) ? Colors.red : Colors.blue
                        )
                      )
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          leading: GestureDetector(
                            onTap:(){
                              id = tarea.idTarea!;
                              print(id);
                              DateTime.parse(tarea.fechaEntrega!).isBefore(DateTime.parse(now)) ? act= 2 : act = 3;
                              _alertActualizar(context, tarea.idTarea, tarea.nomTarea, tarea.dscTarea, tarea.fechaEntrega);
                            },
                            child: Icon(Icons.check, color: Colors.green),
                          ),
                          title: Text('#${tarea.idTarea} - ${tarea.nomTarea}', style: TextStyle( fontWeight: FontWeight.bold)),
                          subtitle: Text('${tarea.dscTarea}', style: TextStyle( color: Colors.black87)),
                        ),
                        Text('Fecha de entrega: ${tarea.fechaEntrega}', style: TextStyle( color: Colors.black54) ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              child: Icon(Icons.edit, color: Colors.yellow[900]),
                              onPressed: (){
                                Navigator.push(context, 
                                MaterialPageRoute(builder: (context) => AgregarTareasScreen(tarea: tarea) )).whenComplete(
                                  (){ setState(() {
                                                      
                                      });
                                    }
                                );
                              },  
                            ),
                            TextButton(
                              child: Icon(Icons.delete, color: Colors.red),
                              onPressed: (){
                                 showDialog(
                                  context: context,
                                  builder: (context){
                                    return AlertDialog(
                                      title: Text('Confirmación'),
                                      content: Text('Estas seguro del borrado?'),
                                      actions: [
                                        TextButton(
                                          onPressed: (){
                                            Navigator.pop(context);
                                            _databaseHelperTarea.delete(tarea.idTarea!).then((noRows){
                                              if(noRows > 0){
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(content: Text('La tarea se ha eliminado'))
                                                );
                                                setState((){
                                                  
                                                });
                                              }
                                            });
            
                                          },
                                          child: Text('Si') ,
                                        ),
                                        TextButton(
                                          child: Text('No'),
                                          onPressed: (){
                                            Navigator.pop(context);
                                          },
                                           
                                        ),
                                      ],
                                    );
                                  }
                                );
                              }
                            ),
                          ])
                      ],),
                    ),
                );
            }
          );
  }

  void _alertActualizar(context, tareaId, nomTarea,dscTarea, fechaEntrega){
    showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          title: Text('Confirmación'),
          content: act == 2 ? Text('Tu tarea se entregara con retardo, presiona confirmar para entregar') : Text('Estas seguro de entregar tu tarea?'),
          actions: [
            TextButton(
              onPressed: (){
                TareasModel tarea = TareasModel(
                  idTarea: tareaId,
                  nomTarea: nomTarea,
                  dscTarea: dscTarea,
                  fechaEntrega: fechaEntrega,
                  entregada: act
                );
                Navigator.pop(context);
               _databaseHelperTarea.updateEntregado(tarea.toMap()).then((noRows){
                  if(noRows > 0){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('La tarea se ha entregado'))
                    );
                    setState((){
                      
                    });
                  }
                });
              },
              child: Text('Si') ,
            ),
            TextButton(
              child: Text('No'),
              onPressed: (){
                Navigator.pop(context);
              },
                
            ),
          ],
        );
      }
    );
  }
}

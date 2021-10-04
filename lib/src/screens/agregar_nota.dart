import 'package:flutter/material.dart';
import 'package:practica2/src/database/database_helper.dart';
import 'package:practica2/src/models/notas_model.dart';
import 'package:practica2/src/utils/color_settings.dart';

class AgregarNotaScreen extends StatefulWidget {
  NotasModel? nota;
  AgregarNotaScreen({Key? key, this.nota}) : super(key: key);

  @override
  _AgregarNotaScreenState createState() => _AgregarNotaScreenState();
}

class _AgregarNotaScreenState extends State<AgregarNotaScreen> {
  
  late DatabaseHelper _databaseHelper;
  
  TextEditingController _controllerTitulo = TextEditingController();
  TextEditingController _controllerDetalle = TextEditingController();

  String TextBar = ''; 

  bool mensajeT = false;
  bool mensajeD = false;
  


  @override
  void initState(){ 

    if(widget.nota != null){
      _controllerTitulo.text = widget.nota!.titulo!;
      _controllerDetalle.text = widget.nota!.detalle!;
      TextBar = 'Editar Nota';
    }else{
      TextBar = 'Agregar Nota';
    }

    _databaseHelper = new DatabaseHelper();
  }


  Widget build(BuildContext context) {
    return Scaffold(
      appBar : AppBar(
        backgroundColor: ColorSettings.colorPrimary,
        title : Text(TextBar),
       
      ),
      body: Column(
        children: [
          _crearTextFieldTitulo(),
          _crearTextFieldDetalle(),
          ElevatedButton(
            onPressed: (){
              setState(() {
                if(_controllerTitulo.text.isEmpty){
                  mensajeT = true;
                }else{
                  mensajeT = false;
                  if(_controllerDetalle.text.isEmpty){
                    mensajeD = true;
                  }else{
                    mensajeD = false;
                    if(widget.nota == null){
                      NotasModel nota = NotasModel(
                        titulo: _controllerTitulo.text,
                        detalle: _controllerDetalle.text,
                      );
                      _databaseHelper.insert(nota.toMap()).then(
                        (value){
                          if(value > 0){
                            Navigator.pop(context);
                          }else{
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('La solicitud no se completo'))
                            );
                          }
                        }
                      );
                    }else{
                      NotasModel nota = NotasModel(
                        id: widget.nota!.id,
                        titulo: _controllerTitulo.text,
                        detalle: _controllerDetalle.text,
                      );
                      _databaseHelper.update(nota.toMap()).then((value){
                        if(value > 0 ){
                          Navigator.pop(context);
                        }else{
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Error, la solicitud no se completo.')
                            )
                          );
                        }
                      });
                    }
                  }
                }
              });
            },
            child: Text('Guardar Nota'),
          )

        ],
      )
    );
  }

  Widget _crearTextFieldTitulo(){
    return Container(
      margin: EdgeInsets.all(15.0),
      child: TextField(
        
        controller: _controllerTitulo,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          labelText: "Titulo de la nota",
          errorText: mensajeT ? 'Este campo es obligatorio' : null
        ),
        onChanged:(value){

        },
      ),
    );
  }

  Widget _crearTextFieldDetalle(){
    return Container(
      margin: EdgeInsets.all(15.0),
      child: TextField(
        controller : _controllerDetalle,
        keyboardType: TextInputType.text,
        maxLines: 8,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          labelText: "Detalle de la nota",
          errorText: mensajeD ? 'Este campo es obligatorio' : null
        ),
        onChanged:(value){

        },
      ),
    );
  }

}